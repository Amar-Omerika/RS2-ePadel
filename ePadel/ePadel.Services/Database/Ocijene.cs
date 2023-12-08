using System;
using System.Collections.Generic;

namespace ePadel.Services.Database
{
    public partial class Ocijene
    {
        public int OcijeneId { get; set; }
        public int? RezervacijaId { get; set; }
        public int? Ocijena { get; set; }
        public string? Komentar { get; set; }

        public virtual Rezervacije? Rezervacija { get; set; }
    }
}
