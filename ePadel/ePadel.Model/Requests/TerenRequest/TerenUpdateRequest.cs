using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.Requests.TerenRequest
{
    public class TerenUpdateRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string? Naziv { get; set; }

        [Required(AllowEmptyStrings = false)]
        public int BrojTerena { get; set; }

        [Required(ErrorMessage = "Cijena je obavezna")]
        public int Cijena { get; set; }
        public string? Popust { get; set; }
        public int CijenaPopusta { get; set; }

        [Required(ErrorMessage = "Tip terena je obavezan")]
        public int TipTerenaId { get; set; }
        [Required(ErrorMessage = "Grad je obavezan")]
        public int GradoviId { get; set; }
    }
}
