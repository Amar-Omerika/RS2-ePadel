using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.Requests.KorisnikRequest
{
    public class KorisnikInsertRequest
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? KorisnickoIme { get; set; }
        public string? Email { get; set; }
        public string? BrTelefona { get; set; }
        public bool? Aktivan { get; set; }
        public  string? Password { get; set; }
        public string? PasswordPotvrda { get; set; }
        public List<int>? Uloge { get; set; } = new List<int>();
    }
}
