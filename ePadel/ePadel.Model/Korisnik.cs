using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model
{
    public partial class Korisnik
    {
        //public Korisnik()
        //{
        //    KorisnikUloges = new HashSet<KorisnikUloge>();
        //    Rezervacijes = new HashSet<Rezervacije>();
        //}
        public int KorisnikId { get; set; }
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? KorisnickoIme { get; set; }
        public string? Email { get; set; }
        public string? BrTelefona { get; set; }
        public bool? Aktivan { get; set; }

    }
}
