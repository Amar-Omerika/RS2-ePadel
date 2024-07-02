using AutoMapper;
using ePadel.Model.Exception;
using ePadel.Model.Requests.FeedbackRequest;
using ePadel.Model.Requests.OcjeneRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.OcjenaService
{
    public class OcjenaService : BaseCRUDService<Model.Ocjene, Database.Ocjene, BaseSearchObject, OcjeneInsertRequest, object>, IOcjenaService
    {
        public OcjenaService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override void BeforeInsert(OcjeneInsertRequest insert, Database.Ocjene entity)
        {
            if (insert == null)
            {
                throw new OcjeneException("Ojcena ne posjeduje vrijednost!");
            }

            if (insert.TerenId == null)
            {
                throw new OcjeneException("Da bi ste dali ocjenu potrebma je staza!");
            }

            if (insert.Ocjena == null)
            {
                throw new OcjeneException("Potrebno je unijeti ocjenu!");
            }

            if (insert.Ocjena < 1 || insert.Ocjena > 5)
            {
                throw new OcjeneException("Ocjena mora biti od 1 do 5!");
            }

            var staza = _context.Terenis.Find(insert.TerenId);

            if (staza == null)
            {
                throw new OcjeneException("Teren ne postoji!");
            }

            base.BeforeInsert(insert, entity);
        }
    }

}
