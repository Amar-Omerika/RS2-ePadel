using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model
{
    public class Tereni
    {
        public int TerenID { get; set; }

        public string? Naziv { get; set; }

        public int BrojTerena { get; set; }

        public decimal Cijena { get; set; }

        public virtual ICollection<TipTerena>? TipTerena { get; set; }

    }
}
