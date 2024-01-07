using ePadel.Model;
using ePadel.Model.Requests.PlatiRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.PlatiService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    public class PlatiTerminController : BaseCRUDController<Model.PlatiTermin,BaseSearchObject,PlatiInsertRequest,PlatiInsertRequest>
    {
        public IPlatiService _service { get; set; }

        public PlatiTerminController(IPlatiService service) : base(service)
        {
            _service = service;
        }

        public override Model.PlatiTermin Insert([FromBody] PlatiInsertRequest request)
        {
            return base.Insert(request);
        }
    }
}
