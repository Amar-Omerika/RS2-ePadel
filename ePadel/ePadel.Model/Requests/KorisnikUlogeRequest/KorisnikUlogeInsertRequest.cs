﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.Requests.KorisnikUlogeRequest
{
    public class KorisnikUlogeInsertRequest
    {
        //[Required]
        public int UlogaId { get; set; }

        //[Required]
        public int KorisnikId { get; set; }
    }
}
