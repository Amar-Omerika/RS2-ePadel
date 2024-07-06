using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.Database
{
    public class Reporti
    {
        public int Id { get; set; }
        public int UkupnaZaradaTerena { get; set; } = 0;
        public int BrojRezervacijeTerena { get; set; } = 0;
        public int UkupanBrojKorisnika { get; set; } = 0;
        public int UkupnaZaradaSistema { get; set; } = 0;
        public int KorisnikId { get; set; }
        public Korisnik Korisnik { get; set; }
    }
}
