using ePadel.Model.Requests.TerenRequest;
using ePadel.Model.Requests.TipTerenaRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.TipTerenaService;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TipTerenaController : BaseCRUDController<Model.TipTerena,BaseSearchObject,TipTerenaInsertRequest,TipTerenaUpdateRequest>
    {
        protected ITipTerenaService? _service { get; set; }
        public TipTerenaController(ITipTerenaService service) : base(service)
        {
        }

        //[Authorize]
        public override Model.TipTerena Insert([FromBody] TipTerenaInsertRequest request)
        {
            return base.Insert(request);
        }

        //[Authorize]
        public override Model.TipTerena Update(int id, [FromBody] TipTerenaUpdateRequest request)
        {
            return base.Update(id, request);
        }

    }
}
