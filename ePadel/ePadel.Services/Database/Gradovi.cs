﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.Database
{
    public class Gradovi
    {
        public int Id { get; set; }
        public string NazivGrada { get; set; }
        public ICollection<Tereni> Tereni { get; } = new List<Tereni>();
    }
}
