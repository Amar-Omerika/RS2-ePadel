using ePadel.Model.Requests.RezervacijaRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.RezervacijaService
{
    public interface IRezervacijaService : IBaseCRUDService<Model.Rezervacije, BaseSearchObject, RezervacijaInsertRequest, RezervacijaUpdateRequest> 
    {
    }
}
