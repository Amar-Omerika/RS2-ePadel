using ePadel.Model.Requests.RezervacijaRequest;
using ePadel.Model.Requests.TerenRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.RezervacijaService;
using ePadel.Services.TerenService;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RezervacijaController : BaseCRUDController<Model.Rezervacije, RezervacijaSearchObject, RezervacijaInsertRequest, RezervacijaUpdateRequest>
    {
        protected IRezervacijaService? _service { get; set; }
        public RezervacijaController(IRezervacijaService service) : base(service)
        {
        }
        public override Model.Rezervacije Insert([FromBody] RezervacijaInsertRequest request)
        {
            return base.Insert(request);
        }

        public override Model.Rezervacije Update(int id, [FromBody] RezervacijaUpdateRequest request)
        {
            return base.Update(id, request);
        }
    }
}
