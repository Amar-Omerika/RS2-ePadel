﻿using System;
using System.Collections.Generic;

namespace ePadel.Services.Database
{
    public partial class Uloga
    {
 
        public int UlogaId { get; set; }
        public string? Naziv { get; set; }

        public virtual ICollection<KorisnikUloge> KorisnikUloges { get; set; }
    }
}
