using System;
using System.Collections.Generic;

namespace ePadel.Services.Database
{
    public partial class KorisničkePreferencije
    {
        public int KorisnikId { get; set; }
        public int? TipTerenaId { get; set; }
        public decimal? MaksimalnaCena { get; set; }
        public string? Lokacija { get; set; }

        public virtual TipTerena? TipTerena { get; set; }
    }
}
