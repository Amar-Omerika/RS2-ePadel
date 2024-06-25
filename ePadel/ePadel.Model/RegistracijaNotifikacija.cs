using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model
{
    public class RegistracijaNotifikacija
    {
        public int RegistracijaNotifikacijaId { get; set; }

        public string Email { get; set; }

        public string PorukaDobrodoslice { get; set; }
    }
}
