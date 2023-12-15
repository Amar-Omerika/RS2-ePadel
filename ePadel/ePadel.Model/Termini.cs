using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model
{
    public class Termini
    {   
        public int TerminId { get; set; }
        public DateTime? Datum { get; set; }
        public TimeSpan? VremePočetka { get; set; }
        public TimeSpan? VremeZavršetka { get; set; }

        public virtual ICollection<Rezervacije>? Rezervacijes { get; set; }
    }
}
