using System;
using System.Collections.Generic;

namespace ePadel.Services.Database
{
    public partial class Rezervacije
    {
  
        public int RezervacijaId { get; set; }
        public int? KorisnikId { get; set; }
        public int? TerenId { get; set; }
        public int? Cijena { get; set; }
        public string? RezervacijaStatus { get; set; }
        public string? PotrebnaReketa { get; set; }
        public int? BrojReketa { get; set; }
        public string? DatumRezervacije { get; set; }
        public string? VrijemeRezervacije { get; set; }
        public string? PaymentMethod { get; set; }
        public string? Lokacija { get; set; }
        public virtual Korisnik? Korisnik { get; set; }
        public virtual Tereni? Teren { get; set; }
        public DateTime DatumKreiranja { get; set; } = DateTime.Now;

    }
}
