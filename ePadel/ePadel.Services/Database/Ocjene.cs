using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.Database
{
    public partial class Ocjene
    {
        public int OcjeneId { get; set; }

        public int Ocjena { get; set; }

        public int TerenId { get; set; }
        public  Tereni? Teren { get; set; }  

    }
}
