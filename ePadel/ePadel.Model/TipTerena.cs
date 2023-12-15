using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model
{
    public class TipTerena
    {
        public int TipTerenaId { get; set; }
        public string? Naziv { get; set; }

        public virtual ICollection<KorisničkePreferencije> KorisničkePreferencijes { get; set; }
        public virtual ICollection<Tereni> Terenis { get; set; }
        public string Slika { get; set; }
    }
}
