using AutoMapper;
using ePadel.Model.Requests.ReportiRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.ReportiService
{
    public class ReportiService : BaseCRUDService<Model.Reporti, Database.Reporti, BaseSearchObject, ReportiInsertRequest, object>, IReportiService
    {
        public ReportiService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public Task<Model.Reporti> GetReporti(int? terenId, string godina)
        {
            var reporti = new Model.Reporti();
            var rezevacijaTerena = _context.Rezervacijes.Where(x => x.TerenId == terenId && x.DatumRezervacije.Contains(godina)).ToList();
            var sveRezervacijePoGodini = _context.Rezervacijes.Where(x => x.DatumRezervacije.Contains(godina)).ToList();
            var sveRezervacijeUkupno = _context.Rezervacijes.ToList();
            var brojKorisnika = _context.Korisniks.ToList();

            if (rezevacijaTerena == null || !rezevacijaTerena.Any())
            {
                reporti.BrojRezervacijeTerena = 0;
                reporti.UkupnaZaradaTerena = 0;
            }
            else
            {
                var brojRezervacijeTerena = rezevacijaTerena.Count();
                var ukupnaZaradaTerena = rezevacijaTerena.Sum(x => x.Cijena);
                reporti.BrojRezervacijeTerena = brojRezervacijeTerena;
                reporti.UkupnaZaradaTerena = (int)ukupnaZaradaTerena;
            }

            if (terenId == null)
            {
                reporti.BrojRezervacijeTerena = sveRezervacijePoGodini.Count();
                reporti.UkupnaZaradaTerena = (int)sveRezervacijePoGodini.Sum(x => x.Cijena);
            }

            if (brojKorisnika == null || !brojKorisnika.Any())
            {
                reporti.UkupnaZaradaSistema = 0;
            }
            else
            {
                var ukupanBrojKorisnikaSistema = brojKorisnika.Count();
                reporti.UkupanBrojKorisnika = ukupanBrojKorisnikaSistema;
            }

            if (sveRezervacijeUkupno == null || !sveRezervacijeUkupno.Any())
            {
                reporti.UkupnaZaradaSistema = 0;
            }
            else
            {
                var ukupnaZaradaSistema = (int)sveRezervacijeUkupno.Sum(x => x.Cijena);
                reporti.UkupnaZaradaSistema = ukupnaZaradaSistema;
            }

            return Task.FromResult(reporti);
        }

    }
}
