using ePadel.Model.Requests.TipTerenaRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.TipTerenaService
{
    public interface ITipTerenaService : IBaseCRUDService<Model.TipTerena, BaseSearchObject, TipTerenaInsertRequest, TipTerenaUpdateRequest>
    {

    }
}
