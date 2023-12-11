using ePadel.Model;
using ePadel.Services.BaseService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Storage;

namespace ePadel.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class BaseController<T, TSearch> : ControllerBase where T : class where TSearch : class
    {
        protected IBaseService<T, TSearch> _service { get; set; }
        public BaseController(IBaseService<T, TSearch> service)
        {
            _service = service;
        }

        //[Authorize]
        [HttpGet]
        public virtual IEnumerable<T> GetAll([FromQuery] TSearch search = null)
        {
            return _service.GetAll(search);
        }

        //[Authorize]
        [HttpGet("{id}")]
        public virtual T GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}