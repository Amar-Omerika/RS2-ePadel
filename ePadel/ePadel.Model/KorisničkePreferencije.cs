using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model
{
    public class KorisničkePreferencije
    {
        public int KorisnikId { get; set; }
        public int? TipTerenaId { get; set; }
        public decimal? MaksimalnaCena { get; set; }
        public string? Lokacija { get; set; }

        public virtual TipTerena? TipTerena { get; set; }
    }
}
