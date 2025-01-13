using ePadel.Model;
using ePadel.Model.Requests.TrenerRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.TrenerService;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [Route("[controller]")]
    public class TrenerController : BaseCRUDController<Treneri, BaseSearchObject, TrenerInsertRequest, TrenerUpdateRequest>
    {
        protected ITrenerService _service { get; set; }
        public TrenerController(ITrenerService service) : base(service)
        {
            _service = service;
        }
    }
}
