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

        [Required]
        public string? VrijemeRezervacije { get; set; }

        [Required(ErrorMessage = "Datum je obavezan.")]
        public string? DatumRezervacije { get; set; }

        [Required]
        public string PaymentMethod { get; set; }

        public int? Cijena { get; set; }
        public string? PotrebnaReketa { get; set; }
        public int? BrojReketa { get; set; }

        //public virtual ICollection<Ocijene>? Ocijenes { get; set; }
    }
}
