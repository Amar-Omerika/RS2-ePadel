using AutoMapper;
using ePadel.Model.Requests.TerenRequest;
using ePadel.Model;
using ePadel.Model.Requests.TipTerenaRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.TipTerenaService
{
    public class TipTerenaService : BaseCRUDService<Model.TipTerena, Database.TipTerena, BaseSearchObject, TipTerenaInsertRequest, TipTerenaUpdateRequest>, ITipTerenaService
    {
        public TipTerenaService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public IQueryable<ePadel.Services.Database.TipTerena> AddFilter(IQueryable<ePadel.Services.Database.TipTerena> query, BaseSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Tekst))
                filteredQuery = filteredQuery.Where(x => x.Naziv.ToLower().Contains(search.Tekst.ToLower()));
            return filteredQuery;
        }
        public override Model.TipTerena Insert(TipTerenaInsertRequest request)
        {
            try
            {
                var tereni = _context.Set<Database.TipTerena>().AsQueryable();

                var entity = base.Insert(request);

                _context.SaveChanges();

                return entity;
            }
            catch (Exception ex)
            {

                throw new UniversalException("Error", $"{ex.Message}");
            }
        }
        public override Model.TipTerena Update(int id, TipTerenaUpdateRequest request)
        {
            try
            {
                var tipTerena = _context.TipTerenas.Where(x => x.TipTerenaId != id && x.Naziv == request.Naziv).ToList();
                return base.Update(id, request);
            }
            catch (Exception ex)
            {

                throw new UniversalException("Error", $"{ex.Message}");
            }

        }

    }
}
