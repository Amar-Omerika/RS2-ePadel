using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.Database
{
    public class Spolovi
    {
        public int Id { get; set; }
        public string TipSpola { get; set; }
        public ICollection<Korisnik> Korisnik { get; } = new List<Korisnik>();
    }
}
