using ePadel.Model;
using ePadel.Model.Requests.KorisnikRequest;
using ePadel.Services.KorisnikService;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Storage;

namespace ePadel.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KorisnikController : ControllerBase
    {

        private readonly IKorisnikService _service;

        public KorisnikController(IKorisnikService service)
        {
            _service = service;
        }

        [HttpGet()]
        public IEnumerable<Model.Korisnik> Get()
        {
            return _service.Get();
        }
        [HttpPost]
        public Model.Korisnik Insert(KorisnikInsertRequest request) { return _service.Insert(request); }

        [HttpPut("{id}")]
        public Model.Korisnik Update(int id, KorisnikUpdateRequest request) { return _service.Update(id,request); }
    }
}