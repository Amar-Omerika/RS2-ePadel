using ePadel.Model;
using ePadel.Model.Requests.PartneriRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.PartneriService;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [Route("[controller]")]
    public class PartneriController : BaseCRUDController<Partneri,BaseSearchObject,PartneriInsertRequest,PartneriUpdateRequest>
    {
        protected IPartneriService _service { get; set; }
        public PartneriController(IPartneriService service) : base(service)
        {
            _service = service;
        }
    }
}
