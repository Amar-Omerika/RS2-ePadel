using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model
{
    public class Obavijesti
    {
        public int ObavijestId { get; set; }
        public string? Naslov { get; set; }
        public string? Sadrzaj { get; set; }
        public DateTime? DatumObjave { get; set; }
    }
}
