using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.Requests.TrenerRequest
{
    public class TrenerUpdateRequest
    {
        [Required(ErrorMessage = "ImePrezime je obavezno")]
        public string? ImePrezime { get; set; }

        [Required(ErrorMessage = "Bio je obavezan")]
        public string? Bio { get; set; }

        [Required(AllowEmptyStrings = false)]
        [RegularExpression("^\\d{3}-\\d{3}-(\\d{4}|\\d{3})$", ErrorMessage = "KontaktTel mora biti u obliku 06X-XXX-XXX !")]
        public string? KontaktTel { get; set; }
    }
}
