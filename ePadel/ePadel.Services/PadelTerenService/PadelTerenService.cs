using ePadel.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.PadelTerenService
{
    public class PadelTerenService : IPadelTerenService
    {
        List<PadelTeren> _padelTereni = new List<PadelTeren>() { new PadelTeren() { TerenID=1,
            Naziv="TestniPadel"
        }};
        public IList<PadelTeren> Get()
        {
            return _padelTereni;
        }
    }
}
