using AutoMapper;
using ePadel.Model.Requests.TrenerRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.TrenerService
{
    public class TrenerService : BaseCRUDService<Model.Treneri, Database.Treneri, BaseSearchObject, TrenerInsertRequest, TrenerUpdateRequest>, ITrenerService
    {
        public TrenerService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
