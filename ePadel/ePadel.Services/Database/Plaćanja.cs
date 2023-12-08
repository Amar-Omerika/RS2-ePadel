using System;
using System.Collections.Generic;

namespace ePadel.Services.Database
{
    public partial class Plaćanja
    {
        public int PlaćanjeId { get; set; }
        public int? RezervacijaId { get; set; }
        public decimal? Iznos { get; set; }
        public string? MetodaPlaćanja { get; set; }
        public DateTime? DatumPlaćanja { get; set; }

        public virtual Rezervacije? Rezervacija { get; set; }
    }
}
