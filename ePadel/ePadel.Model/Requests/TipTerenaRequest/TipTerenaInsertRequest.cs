using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.Requests.TipTerenaRequest
{
    public class TipTerenaInsertRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string? Naziv { get; set; }

        public string? Slika { get; set; }

    }
}
