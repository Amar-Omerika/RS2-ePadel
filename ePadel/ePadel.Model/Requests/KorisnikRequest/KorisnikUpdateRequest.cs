using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.Requests.KorisnikRequest
{
    public class KorisnikUpdateRequest
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? Email { get; set; }
        public string? BrTelefona { get; set; }
        public bool? Aktivan { get; set; }
    }
}
