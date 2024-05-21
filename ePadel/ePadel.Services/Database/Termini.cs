using System;
using System.Collections.Generic;

namespace ePadel.Services.Database
{
    public partial class Termini
    {

        public int TerminId { get; set; }
        public DateTime? Datum { get; set; }
        public TimeSpan? VremePočetka { get; set; }
        public TimeSpan? VremeZavršetka { get; set; }
        public bool? rezervisan { get; set; }

        public virtual ICollection<Rezervacije> Rezervacijes { get; set; }
    }
}
