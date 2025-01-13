using ePadel.Model;
using ePadel.Model.Requests.TrenerRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.TrenerService
{
    public interface ITrenerService : IBaseCRUDService<Model.Treneri, BaseSearchObject, TrenerInsertRequest,TrenerUpdateRequest>
    {
    }
}
