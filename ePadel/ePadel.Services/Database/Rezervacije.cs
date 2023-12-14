using System;
using System.Collections.Generic;

namespace ePadel.Services.Database
{
    public partial class Rezervacije
    {
  
        public int RezervacijaId { get; set; }
        public int? KorisnikId { get; set; }
        public int? TerenId { get; set; }
        public int? TerminId { get; set; }
        public string? RezervacijaStatus { get; set; }
        public DateTime? DatumRezervacije { get; set; }

        public virtual Korisnik? Korisnik { get; set; }
        public virtual Tereni? Teren { get; set; }
        public virtual Termini? Termin { get; set; }
        public virtual ICollection<Ocijene>? Ocijenes { get; set; }
        public virtual ICollection<Plaćanja>? Plaćanjas { get; set; }
    }
}
