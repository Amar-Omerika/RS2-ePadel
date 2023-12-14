using System;
using System.Collections.Generic;

namespace ePadel.Services.Database
{
    public partial class TipTerena
    {
  
        public int TipTerenaId { get; set; }
        public string? Naziv { get; set; }

        public virtual ICollection<KorisničkePreferencije> KorisničkePreferencijes { get; set; }
        public virtual ICollection<Tereni> Terenis { get; set; }
        public string Slika { get; set; }
    }
}
