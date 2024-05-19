using ePadel.Model.Requests.TerenRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.TerenService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TerenController : BaseCRUDController<Model.Tereni,TerenSearchObject,TerenInsertRequest,TerenUpdateRequest>
    {
        protected ITerenService? _service { get; set; }
        public TerenController(ITerenService service) : base(service)
        {
            _service = service;
        }
        public override Model.Tereni Insert([FromBody] TerenInsertRequest request)
        {
            return base.Insert(request);
        }

        public override Model.Tereni Update(int id, [FromBody] TerenUpdateRequest request)
        {
            return base.Update(id, request);
        }

        [HttpGet("recommend")]
        public List<Model.Tereni> Recommend()
        {
            return _service.TereniRecommendedSystem();
        }
    }
}
