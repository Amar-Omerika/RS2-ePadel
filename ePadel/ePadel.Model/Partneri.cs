using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model
{
    public class Partneri
    {
        public int PartnerId { get; set; }
        public string? Naziv { get; set; }
        public string? Deskripcija { get; set; }
        public DateTime? DatumObjave { get; set; }
    }
}
