using AutoMapper;
using ePadel.Model.Requests.ObavijestiRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.ObavijestiService
{
    public class ObavijestiService : BaseCRUDService<Model.Obavijesti,Database.Obavijesti,BaseSearchObject,ObavijestiInsertRequest,ObavijestiUpdateRequest>, IObavijestiService
    {
        public ObavijestiService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {

        }
    }
}
