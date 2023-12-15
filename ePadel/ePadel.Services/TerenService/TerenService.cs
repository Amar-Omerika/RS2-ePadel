using AutoMapper;
using ePadel.Model;
using ePadel.Model.Requests.TerenRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.TerenService
{
    public class TerenService : BaseCRUDService<Model.Tereni, Database.Tereni, BaseSearchObject, TerenInsertRequest, TerenUpdateRequest>, ITerenService
    {
        public TerenService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public IQueryable<ePadel.Services.Database.Tereni> AddFilter(IQueryable<ePadel.Services.Database.Tereni> query, BaseSearchObject search = null)
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
    }
}
