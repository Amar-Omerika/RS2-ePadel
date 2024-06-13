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
    
        [Range(0.01, double.MaxValue, ErrorMessage = "Cijena ne moze biti manja ili jednaka 0")]
        public int Cijena { get; set; }

        [Required]
        public int? KorisnikId { get; set; }

        [Required]
        public int? TerenId { get; set; }



    }
}
