using ePadel.Model;
using ePadel.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace ePadel.Services.PadelTerenService
{
    public class PadelTerenService : IPadelTerenService
    {
        IB190069_ePadelContext _context;
        public PadelTerenService(IB190069_ePadelContext context)
        {
            _context = context;
        }
        List<Model.PadelTeren> padelTereni = new List<Model.PadelTeren>() { new PadelTeren() { TerenID=1,
            Naziv="TestniPadel"
        }};
        public IList<PadelTeren> Get()
        {
            //var list = _context.Plaćanjas.ToList();
            return padelTereni;
        }
    }
}
