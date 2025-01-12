using AutoMapper;
using ePadel.Model;
using ePadel.Model.Requests.PartneriRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.PartneriService
{
    public class PartneriService : BaseCRUDService<Model.Partneri, Database.Partneri,BaseSearchObject,PartneriInsertRequest,PartneriUpdateRequest>, IPartneriService
    {
        public PartneriService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {

        }
    }
}
