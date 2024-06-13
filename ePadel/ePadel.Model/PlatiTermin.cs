using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model
{
    public class PlatiTermin
    {
        public int PlatiTerminId { get; set; }
        public string? PaymentIntentId { get; set; }
        public int CijenaTermina { get; set; }
        public bool? Placena { get; set; }
        public bool Izbrisan { get; set; }
        public string PaymentMethod { get; set; }
        public int? KorisnikId { get; set; }
        public int? TerenId { get; set; }
        public int? RezervacijaId { get; set; }
        public virtual Korisnik? Korisnik { get; set; }
        public virtual Tereni? Teren { get; set; }
    }
}
