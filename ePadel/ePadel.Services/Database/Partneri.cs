﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.Database
{
    public class Partneri
    {
        [Key]
        public int PartnerId { get; set; }
        public string? Naziv { get; set; }
        public string? Deskripcija { get; set; }
        public DateTime? DatumObjave { get; set; }
    }
}
