using ePadel.Model;
using ePadel.Model.Requests.OcjeneRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.OcjenaService;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [Route("[controller]")]
    public class OcjeneController : BaseCRUDController<Ocjene, BaseSearchObject, OcjeneInsertRequest, object>
    {
        protected IOcjenaService _service { get; set; }
        public OcjeneController(IOcjenaService service) : base(service)
        {
            _service = service;
        }
    }
}
