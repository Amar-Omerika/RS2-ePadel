using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.Requests.PartneriRequest
{
    public class PartneriInsertRequest
    {
        [Required(ErrorMessage = "Naziv je obavezan")]
        public string? Naziv { get; set; }

        [Required(ErrorMessage = "Deskripcija je obavezan")]
        public string? Deskripcija { get; set; }
        public DateTime? DatumObjave { get; set; } = DateTime.Now;
    }
}
