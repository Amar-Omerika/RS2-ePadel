using ePadel.Model;
using ePadel.Model.Enums;
using ePadel.Model.Requests.KorisnikRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.KorisnikService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Storage;

namespace ePadel.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KorisnikController : BaseCRUDController<Model.Korisnik, KorisnikSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        protected IKorisnikService? _service { get; set; }
        public KorisnikController(IKorisnikService service) : base(service)
        {
        }

        public override Model.Korisnik Insert([FromBody] KorisnikInsertRequest request)
        {
            return base.Insert(request);
        }

        public override Model.Korisnik Update(int id, [FromBody] KorisnikUpdateRequest request)
        {
            return base.Update(id, request);
        }

        [HttpGet("spolovi")]
        public ActionResult<IEnumerable<string>> GetSpolovi()
        {
            var spolovi = Enum.GetValues(typeof(Spol)).Cast<Spol>().Select(s => s.ToString()).ToList();
            return Ok(spolovi);
        }
    }
}