using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.Database
{
    public partial class PlatiTermin
    {
        public int PlatiTerminId { get; set; }
        public int Cijena { get; set; }
        public DateTime? DatumKupovine { get; set; }
        public string? PaymentIntentId { get; set; }
        public bool? Placena { get; set; }
        public int? KorisnikId { get; set; }
        public virtual Korisnik? Korisnik { get; set; }
        public int? TerminId { get; set; }
        public virtual Termini? Termin { get; set; }
        public int? TerenId { get; set; }
        public virtual Tereni? Teren { get; set; }
    }
}
