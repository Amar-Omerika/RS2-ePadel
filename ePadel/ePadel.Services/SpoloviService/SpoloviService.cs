using AutoMapper;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using ePadel.Services.Gradovi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.SpoloviService
{
    public class SpoloviService : BaseCRUDService<Model.Spol, Database.Spolovi, BaseSearchObject, object, object>, ISpoloviService
    {
        public SpoloviService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {
        }

    }
}
