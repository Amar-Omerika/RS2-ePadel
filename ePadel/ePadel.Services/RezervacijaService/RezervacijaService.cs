using AutoMapper;
using ePadel.Model;
using ePadel.Model.Requests.RezervacijaRequest;
using ePadel.Model.Requests.TerenRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using ePadel.Services.Helper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.RezervacijaService
{
    public class RezervacijaService : BaseCRUDService<Model.Rezervacije, Database.Rezervacije, RezervacijaSearchObject, RezervacijaInsertRequest, RezervacijaUpdateRequest>, IRezervacijaService
    {
        public RezervacijaService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<ePadel.Services.Database.Rezervacije> AddInclude(IQueryable<ePadel.Services.Database.Rezervacije> query, RezervacijaSearchObject search = null)
        {
            query = query.Include(x => x.Korisnik).Include(x => x.Teren);
            return base.AddInclude(query, search);
        }
        public override IQueryable<ePadel.Services.Database.Rezervacije> AddFilter(IQueryable<ePadel.Services.Database.Rezervacije> query, RezervacijaSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search != null && search.terenId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.TerenId == search.terenId);
            }
            return filteredQuery;


        }
        public List<string> getSlotsForReservationDate(int terenId, string datumRezervacije)
        {
            var reservations = _context.Rezervacijes.Where(c => c.DatumRezervacije == datumRezervacije && c.TerenId == terenId);
            List<string> slots = TImeSlotsHelper.getTimeSlots();
            List<string> responseSlots = new List<string> { };
            foreach (string slot in slots)
            {

                if (!reservations.Any(r => r.VrijemeRezervacije == slot))
                    responseSlots.Add(slot);
            };
            return responseSlots;
        }
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
