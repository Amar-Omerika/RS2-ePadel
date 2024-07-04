using AutoMapper;
using ePadel.Model.Requests.OcjeneRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.Gradovi
{
    public class GradoviService : BaseCRUDService<Model.Grad, Database.Gradovi, BaseSearchObject, object, object>, IGradoviService
    {
        public GradoviService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {
        }

    }
}
