using ePadel.Model;
using ePadel.Services.PadelTerenService;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PadelTerenController : ControllerBase
    {

        private readonly IPadelTerenService _padelTerenService;

        public PadelTerenController(IPadelTerenService padelTerenService)
        {
          _padelTerenService = padelTerenService;
        }

        [HttpGet()]
        public IEnumerable<PadelTeren> Get()
        {
            return _padelTerenService.Get();
        }
    }
}