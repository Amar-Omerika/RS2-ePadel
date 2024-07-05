using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model
{
    public partial class Korisnik
    {
        public int KorisnikId { get; set; }
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public string? KorisnickoIme { get; set; }
        public string? Email { get; set; }
        public bool? Aktivan { get; set; }
        public string? Spol {
            get
            {
                return Spolovi?.TipSpola;
            }
        }
        public string? DominantnaRuka { get; set; }
        public string? Slika { get; set; }
        public Spol Spolovi { get; set; }
        public virtual ICollection<KorisnikUloge>? KorisnikUloges { get; set; }

    }
}
