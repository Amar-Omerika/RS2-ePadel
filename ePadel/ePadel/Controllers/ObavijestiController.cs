using ePadel.Model;
using ePadel.Model.Requests.ObavijestiRequest;
using ePadel.Model.Requests.OcjeneRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.ObavijestiService;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [Route("[controller]")]
    public class ObavijestiController : BaseCRUDController<Obavijesti, BaseSearchObject, ObavijestiInsertRequest, ObavijestiUpdateRequest>
    {
        protected IObavijestiService _service { get; set; }
        public ObavijestiController(IObavijestiService service) : base(service)
        {
            _service = service;
        }
    }
}
