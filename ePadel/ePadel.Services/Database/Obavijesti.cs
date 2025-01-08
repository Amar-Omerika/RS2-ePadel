using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.Database
{
    public partial class Obavijesti
    {
        [Key]
        public int ObavijestId { get; set; }
        public string? Naslov { get; set; }
        public string? Sadrzaj { get; set; }
        public DateTime? DatumObjave { get; set; }
    }
}
