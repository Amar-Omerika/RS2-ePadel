using ePadel.Model.Requests.KorisnikRequest;
using ePadel.Model.Requests.TerenRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.KorisnikService;
using ePadel.Services.TerenService;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TerenController : BaseCRUDController<Model.Tereni,BaseSearchObject,TerenInsertRequest,TerenUpdateRequest>
    {
        protected ITerenService? _service { get; set; }
        public TerenController(ITerenService service) : base(service)
        {
        }
        //[Authorize]
        public override Model.Tereni Insert([FromBody] TerenInsertRequest request)
        {
            return base.Insert(request);
        }

        //[Authorize]
        public override Model.Tereni Update(int id, [FromBody] TerenUpdateRequest request)
        {
            return base.Update(id, request);
        }
    }
}
