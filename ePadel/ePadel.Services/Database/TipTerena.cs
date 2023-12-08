using System;
using System.Collections.Generic;

namespace ePadel.Services.Database
{
    public partial class TipTerena
    {
        public TipTerena()
        {
            KorisničkePreferencijes = new HashSet<KorisničkePreferencije>();
            Terenis = new HashSet<Tereni>();
        }

        public int TipTerenaId { get; set; }
        public string? Naziv { get; set; }

        public virtual ICollection<KorisničkePreferencije> KorisničkePreferencijes { get; set; }
        public virtual ICollection<Tereni> Terenis { get; set; }
    }
}
