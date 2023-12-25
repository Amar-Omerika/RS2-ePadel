using ePadel.Model.Requests.PlatiRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.PlatiService
{
    public interface IPlatiService : IBaseCRUDService<Model.PlatiTermin,BaseSearchObject,PlatiInsertRequest,PlatiInsertRequest>
    {
    }
}
