using System;
using System.Collections.Generic;

namespace ePadel.Services.Database
{
    public partial class Termini
    {
        public Termini()
        {
            Rezervacijes = new HashSet<Rezervacije>();
        }

        public int TerminId { get; set; }
        public DateTime? Datum { get; set; }
        public TimeSpan? VremePočetka { get; set; }
        public TimeSpan? VremeZavršetka { get; set; }

        public virtual ICollection<Rezervacije> Rezervacijes { get; set; }
    }
}
