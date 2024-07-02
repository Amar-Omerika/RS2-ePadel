using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace ePadel.Services.Database
{
    public partial class Tereni
    {
        public int TerenId { get; set; }
        public string? Naziv { get; set; }
        public int? BrojTerena { get; set; }
        public int? Cijena { get; set; }
        public string? Lokacija { get; set; }
        public string? Popust { get; set; }
        public int CijenaPopusta { get; set; }
        public int? TipTerenaId { get; set; }

        public virtual TipTerena? TipTerena { get; set; }
        public ICollection<Ocjene> Ocjenes { get; } = new List<Ocjene>();

        [NotMapped] // Add this attribute to indicate that Revenue is not mapped to the database
        public float Revenue { get; internal set; }
    }
}
