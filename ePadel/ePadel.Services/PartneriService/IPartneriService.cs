using ePadel.Model;
using ePadel.Model.Requests.PartneriRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.PartneriService
{
    public interface IPartneriService : IBaseCRUDService<Partneri,BaseSearchObject,PartneriInsertRequest, PartneriUpdateRequest>
    {
    }
}
