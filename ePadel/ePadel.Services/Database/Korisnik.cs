using ePadel.Model.Enums;
using System;
using System.Collections.Generic;

namespace ePadel.Services.Database
{
    public partial class Korisnik
    {
   
        public int KorisnikId { get; set; }
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? KorisnickoIme { get; set; }
        public string? Email { get; set; }
        public string? BrTelefona { get; set; }
        public string? LozinkaHash { get; set; }
        public string? LozinkaSalt { get; set; }
        public string? DominantnaRuka { get; set; }

        public Spol Spol { get; set; }
        public bool? Aktivan { get; set; }

        
        public virtual ICollection<KorisnikUloge> KorisnikUloges { get; set; }
        public virtual ICollection<Rezervacije>? Rezervacijes { get; set; }
        public virtual IEnumerable<Reporti>? Reportis { get; set; }

        public string Slika { get; set; }
    }
}
