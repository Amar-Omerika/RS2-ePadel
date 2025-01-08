using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.Requests.ObavijestiRequest
{
    public class ObavijestiUpdateRequest
    {
        [Required(ErrorMessage = "Naslov je obavezan")]
        public string? Naslov { get; set; }

        [Required(ErrorMessage = "Sadrzaj je obavezan")]
        public string? Sadrzaj { get; set; }
    }
}
