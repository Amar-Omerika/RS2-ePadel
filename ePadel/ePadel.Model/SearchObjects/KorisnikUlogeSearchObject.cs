using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.SearchObjects
{
    public class KorisnikUlogeSearchObject : BaseSearchObject
    {
        public int? UlogaId { get; set; }
        public int? KorisnikId { get; set; }
    }
}
