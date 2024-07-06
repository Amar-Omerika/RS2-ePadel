using ePadel.Model.SearchObjects;
using ePadel.Model;
using ePadel.Services.BaseService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ePadel.Model.Requests.ReportiRequest;

namespace ePadel.Services.ReportiService
{
    public interface IReportiService : IBaseCRUDService<Reporti, BaseSearchObject, ReportiInsertRequest, object>
    {
        Task<Reporti> GetReporti(int? terenId, string godina);
    }
}
