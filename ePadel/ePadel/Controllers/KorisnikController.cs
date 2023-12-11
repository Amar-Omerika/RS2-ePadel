using ePadel.Model;
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
    public class KorisnikController : BaseCRUDController<Model.Korisnik, BaseSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        protected IKorisnikService _service { get; set; }
        public KorisnikController(IKorisnikService service) : base(service)
        {
        }

        //[Authorize]
        public override Model.Korisnik Insert([FromBody] KorisnikInsertRequest request)
        {
            return base.Insert(request);
        }

        //[Authorize]
        public override Model.Korisnik Update(int id, [FromBody] KorisnikUpdateRequest request)
        {
            return base.Update(id, request);
        }
    }
}