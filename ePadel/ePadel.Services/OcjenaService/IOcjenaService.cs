using ePadel.Model;
using ePadel.Model.Requests.OcjeneRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.OcjenaService
{
    public interface IOcjenaService : IBaseCRUDService<Ocjene, BaseSearchObject, OcjeneInsertRequest, object>
    {
    }
}
