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
using System.Linq;
using System.Collections.Generic;


namespace ePadel.Services.TerenService
{
    public class TerenService : BaseCRUDService<Model.Tereni, Database.Tereni, TerenSearchObject, TerenInsertRequest, TerenUpdateRequest>, ITerenService
    {
        public TerenService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<ePadel.Services.Database.Tereni> AddInclude(IQueryable<ePadel.Services.Database.Tereni> query, TerenSearchObject search = null)
        {
            query = query.Include(x => x.TipTerena).Include(x => x.Ocjenes).Include(x=>x.Gradovi);
            return base.AddInclude(query, search);
        }
        public override IQueryable<ePadel.Services.Database.Tereni> AddFilter(IQueryable<ePadel.Services.Database.Tereni> query, TerenSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Tekst))
            {
                filteredQuery = filteredQuery.Where(x => x.Naziv.ToLower().Contains(search.Tekst.ToLower()));
            }

            if (!string.IsNullOrWhiteSpace(search?.TipTerenaTekst))
            {
                filteredQuery = filteredQuery.Where(x => x.TipTerena.Naziv.ToLower().Contains(search.TipTerenaTekst.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.Popust))
            {
                filteredQuery = filteredQuery.Where(x => x.Popust.ToLower().Contains(search.Popust.ToLower()));
            }

            return filteredQuery;
        }
        public override Model.Tereni Insert(TerenInsertRequest request)
        {
            if (request.Popust != "Da" && request.Popust != "Ne")
            {
                throw new UniversalException("Validation Error", "Definiranje popusta prihvata samo Da ili Ne u ovom formatu.");
            }
            if (request.Popust == "Da")
            {
                if (request.CijenaPopusta <= 0)
                {
                    throw new UniversalException("Validation Error", "Cijena popusta mora biti veća od nule.");
                }

                if (request.CijenaPopusta >= request.Cijena)
                {
                    throw new UniversalException("Validation Error", "Cijena popusta mora biti manja od osnovne cijene.");
                }
            }


            if (request.Popust == "Ne" && request.CijenaPopusta > 0)
            {
                throw new UniversalException("Validation Error", "Morate definirati popust kao Da kako bi ste mogli definirati cijenu popusta koja mora biti veca od 0.");
            }

            var tereni = _context.Set<Database.Tereni>().AsQueryable();

            var entity = base.Insert(request);

            _context.SaveChanges();

            return entity;

        }
        public override Model.Tereni Update(int id, TerenUpdateRequest request)
        {
            if (request.Popust != "Da" && request.Popust != "Ne")
            {
                throw new UniversalException("Validation Error", "Definiranje popusta prihvata samo Da ili Ne u ovom formatu.");
            }
            if (request.Popust == "Da")
            {
                if (request.CijenaPopusta <= 0)
                {
                    throw new UniversalException("Validation Error", "Cijena popusta mora biti veća od nule.");
                }

                if (request.CijenaPopusta >= request.Cijena)
                {
                    throw new UniversalException("Validation Error", "Cijena popusta mora biti manja od osnovne cijene.");
                }
            }

            if (request.Popust == "Ne" && request.CijenaPopusta > 0)
            {
                throw new UniversalException("Validation Error", "Morate definirati popust kao Da kako bi ste mogli definirati cijenu popusta koja mora biti veca od 0.");
            }

            var terenSaImenom = _context.Terenis.Where(x => x.TerenId != id && x.Naziv == request.Naziv).ToList();
            
            return base.Update(id, request);
  
        }

        public List<Model.Tereni> TereniSaPopustom()
        {
            var tereniSaPopustom = _context.Terenis
                .Where(t => t.Popust == "Da")
                .Include(t => t.TipTerena).Include(g=>g.Gradovi)
                .ToList();

            foreach (var teren in tereniSaPopustom)
            {
                teren.Cijena -= teren.CijenaPopusta;
            }

            return _mapper.Map<List<Model.Tereni>>(tereniSaPopustom);
        }

        static object isLocked = new object();
        static MLContext? mlContext = null;
        static ITransformer? model = null;

        public List<Model.Tereni> TereniRecommendedSystem()
        {
            var rezervacije = _context.Rezervacijes
                .Include(r => r.Teren).Include(r => r.Teren.TipTerena).Include(g => g.Teren.Gradovi)
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
