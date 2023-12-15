using ePadel.Model.Requests.TerenRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.TerenService
{
    public interface ITerenService : IBaseCRUDService<Model.Tereni,BaseSearchObject,TerenInsertRequest,TerenUpdateRequest> 
    {
    }
 
}
