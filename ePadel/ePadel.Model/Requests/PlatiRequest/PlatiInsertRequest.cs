using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.Requests.PlatiRequest
{
    public class PlatiInsertRequest
    {
        [Required]
        public int Cijena { get; set; }

        [Required]
        public int? KorisnikId { get; set; }

        [Required]
        public int? TerminId { get; set; }
   

    }
}
