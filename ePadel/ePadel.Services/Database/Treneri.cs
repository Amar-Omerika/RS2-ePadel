using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.Database
{
    public partial class Treneri
    {
        [Key]
        public int TrenerId { get; set; }
        public string? ImePrezime { get; set; }
        public string? Bio { get; set; }
        public string? KontaktTel { get; set; }
    }
}
