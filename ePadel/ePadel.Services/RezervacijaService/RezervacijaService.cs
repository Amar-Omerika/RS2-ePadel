using AutoMapper;
using ePadel.Model;
using ePadel.Model.Requests.RezervacijaRequest;
using ePadel.Model.Requests.TerenRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.RezervacijaService
{
    public class RezervacijaService : BaseCRUDService<Model.Rezervacije, Database.Rezervacije, BaseSearchObject, RezervacijaInsertRequest, RezervacijaUpdateRequest>, IRezervacijaService
    {
        public RezervacijaService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<ePadel.Services.Database.Rezervacije> AddInclude(IQueryable<ePadel.Services.Database.Rezervacije> query, BaseSearchObject search = null)
        {
            query = query.Include(x => x.Korisnik).Include(x => x.Teren);
            return base.AddInclude(query, search);
        }
        //public override IQueryable<ePadel.Services.Database.Rezervacije> AddFilter(IQueryable<ePadel.Services.Database.Rezervacije> query, BaseSearchObject search = null)
        //{
        //    var filteredQuery = base.AddFilter(query, search);

        //    if (!string.IsNullOrWhiteSpace(search?.Tekst))
        //        filteredQuery = filteredQuery.Where(x => x.Naziv.ToLower().Contains(search.Tekst.ToLower()));
        //    return filteredQuery;


        //}
        public override Model.Rezervacije Insert(RezervacijaInsertRequest request)
        {
            try
            {
                var tereni = _context.Set<Database.Rezervacije>().AsQueryable();

                var entity = base.Insert(request);

                _context.SaveChanges();

                return entity;
            }
            catch (Exception ex)
            {

                throw new UniversalException("Error", $"{ex.Message}");
            }
        }
        public override Model.Rezervacije Update(int id, RezervacijaUpdateRequest request)
        {
            try
            {
                var rezervacija = _context.Rezervacijes.Where(x => x.RezervacijaId != id ).ToList();
                return base.Update(id, request);
            }
            catch (Exception ex)
            {

                throw new UniversalException("Error", $"{ex.Message}");
            }

        }
    }
}
