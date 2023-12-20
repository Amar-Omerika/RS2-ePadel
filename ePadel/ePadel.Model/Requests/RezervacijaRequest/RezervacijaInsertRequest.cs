using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.Requests.RezervacijaRequest
{
    public class RezervacijaInsertRequest
    {

        [Required]
        public int? KorisnikId { get; set; }

        [Required(ErrorMessage = "Teren je obavezan")]
        public int? TerenId { get; set; }

        [Required(ErrorMessage = "Potrebno je odabrati termin.")]
        public int TerminId { get; set; }
        public string? RezervacijaStatus { get; set; }

        [Required(ErrorMessage = "Datum je obavezan.")]
        public DateTime? DatumRezervacije { get; set; }

        //public virtual ICollection<Ocijene>? Ocijenes { get; set; }
    }
}
