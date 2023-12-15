using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model
{
    public class Ocijene
    {
        public int OcijeneId { get; set; }
        public int? RezervacijaId { get; set; }
        public int? Ocijena { get; set; }
        public string? Komentar { get; set; }

        public virtual Rezervacije? Rezervacija { get; set; }
    }
}
