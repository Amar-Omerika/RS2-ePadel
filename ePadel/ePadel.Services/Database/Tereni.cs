using System;
using System.Collections.Generic;

namespace ePadel.Services.Database
{
    public partial class Tereni
    {
        public int TerenId { get; set; }
        public string? Naziv { get; set; }
        public int? BrojTerena { get; set; }
        public int? Cijena { get; set; }
        public int? TipTerenaId { get; set; }

        public virtual TipTerena? TipTerena { get; set; }
        public virtual ICollection<Rezervacije> Rezervacijes { get; set; }
    }
}
