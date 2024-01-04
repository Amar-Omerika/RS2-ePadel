using AutoMapper;
using ePadel.Model;
using ePadel.Model.Requests.TerenRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;


namespace ePadel.Services.TerenService
{
    public class TerenService : BaseCRUDService<Model.Tereni, Database.Tereni, BaseSearchObject, TerenInsertRequest, TerenUpdateRequest>, ITerenService
    {
        public TerenService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<ePadel.Services.Database.Tereni> AddInclude(IQueryable<ePadel.Services.Database.Tereni> query, BaseSearchObject search = null)
        {
            query = query.Include(x => x.TipTerena);
            return base.AddInclude(query, search);
        }
        public override IQueryable<ePadel.Services.Database.Tereni> AddFilter(IQueryable<ePadel.Services.Database.Tereni> query, BaseSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Tekst))
                filteredQuery = filteredQuery.Where(x => x.Naziv.ToLower().Contains(search.Tekst.ToLower()));
            return filteredQuery;

           
        }
        public override Model.Tereni Insert(TerenInsertRequest request)
        {
            try
            {
                var tereni = _context.Set<Database.Tereni>().AsQueryable();

                var entity = base.Insert(request);

                _context.SaveChanges();

                return entity;
            }
            catch (Exception ex)
            {

                throw new  UniversalException("Error",$"{ex.Message}");
            }
        }
        public override Model.Tereni Update(int id, TerenUpdateRequest request)
        {
            try
            {
                var terenSaImenom = _context.Terenis.Where(x => x.TerenId != id && x.Naziv == request.Naziv).ToList();
                return base.Update(id, request);
            }
            catch (Exception ex)
            {

                throw new UniversalException("Error", $"{ex.Message}");
            }       
      
        }
        static object isLocked = new object();
        static MLContext? mlContext = null;
        static ITransformer? model = null;

        public List<Model.Tereni> TereniRecommendedSystem()
        {
            var rezervacije = _context.Rezervacijes
                .Include(r => r.Teren)
                .ToList();

            if (rezervacije.Count < 3)
            {
                throw new Exception("Morate imati minimum 3 rezervacije ukoliko zelite da vam sistem nesto predloži!");
            }

            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();

                    var data = new List<TereniEntry>();

                    var tereniPrihodi = rezervacije
                        .GroupBy(r => r.TerenId)
                        .Select(group => new
                        {
                            TerenId = group.Key.GetValueOrDefault(),
                            Revenue = group.Sum(r => r.Teren?.Cijena.GetValueOrDefault())
                        }).ToList();

                    foreach (var rezervacija in rezervacije)
                    {
                        var terenPrihod = tereniPrihodi.FirstOrDefault(g => g.TerenId == rezervacija.TerenId.GetValueOrDefault());
                        data.Add(new TereniEntry
                        {
                            TerenId = (uint)rezervacija.TerenId.GetValueOrDefault(),
                            Revenue = (float)terenPrihod.Revenue
                        });
                    }

                    if (!data.Any())
                    {
                        throw new Exception("Trening podadci su prazni!");
                    }

                    var trainData = mlContext.Data.LoadFromEnumerable(data);
                    var trainTestSplit = mlContext.Data.TrainTestSplit(trainData, testFraction: 0.2);

                    var options = new MatrixFactorizationTrainer.Options
                    {
                        MatrixColumnIndexColumnName = nameof(TereniEntry.TerenId),
                        MatrixRowIndexColumnName = nameof(TereniEntry.TerenId),
                        LabelColumnName = "Revenue",
                        LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass,
                        Alpha = 0.01,
                        Lambda = 0.025
                    };

                    var trainer = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    model = trainer.Fit(trainTestSplit.TrainSet);
                    if (model == null)
                    {
                        throw new Exception("Treniranje modela neuspijesno, model rezultira sa vrijednosti null.");
                    }
                }
            }

            var predictionResult = new List<Tuple<Database.Tereni, float>>();
            var tereni = _context.Terenis.ToList();

            foreach (var teren in tereni)
            {
                var predictionEngine = mlContext.Model.CreatePredictionEngine<TereniEntry, TereniPrediction>(model);
                var prediction = predictionEngine.Predict(new TereniEntry()
                {
                    TerenId = (uint)teren.TerenId,
                    Revenue = teren.Revenue
                });

                predictionResult.Add(new Tuple<Database.Tereni, float>(teren, prediction.Score));
            }

            var finalResult = predictionResult.OrderByDescending(x => x.Item2)
                .Select(x => x.Item1)
                .ToList()
                .Take(3);

            return _mapper.Map<List<Model.Tereni>>(finalResult);
        }


        public class TereniEntry
        {
           

            [KeyType(count: 10)]
            public uint TerenId { get; set; }

            public float Revenue { get; set; }
        }

        public class TereniPrediction
        {
            public float Score { get; set; }
        }
    }
}
