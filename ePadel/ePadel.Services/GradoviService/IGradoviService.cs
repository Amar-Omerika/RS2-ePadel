using ePadel.Services.BaseService;
using ePadel.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ePadel.Model.SearchObjects;

namespace ePadel.Services.Gradovi
{
    public interface IGradoviService : IBaseCRUDService<Grad, BaseSearchObject, object, object>
    {
    }
    
}
