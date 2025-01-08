using ePadel.Model;
using ePadel.Model.Requests.ObavijestiRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.ObavijestiService
{
    public interface IObavijestiService:IBaseCRUDService<Obavijesti,BaseSearchObject, ObavijestiInsertRequest, ObavijestiUpdateRequest>
    {

    }
}
