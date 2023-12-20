using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.Requests.RezervacijaRequest
{
    public class RezervacijaUpdateRequest
    {
        public int RezervacijaId { get; set; }

        [Required]
        public int? KorisnikId { get; set; }

        [Required]
        public int? TerenId { get; set; }
        public int? TerminId { get; set; }
        public string? RezervacijaStatus { get; set; }

        [Required]
        public DateTime? DatumRezervacije { get; set; }

        public virtual Korisnik? Korisnik { get; set; }
        public virtual Tereni? Teren { get; set; }
        public virtual Termini? Termin { get; set; }
        public virtual ICollection<Ocijene>? Ocijenes { get; set; }
    }
}
