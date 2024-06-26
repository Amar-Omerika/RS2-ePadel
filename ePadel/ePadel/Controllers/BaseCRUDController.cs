﻿using ePadel.Controllers;
using ePadel.Services.BaseService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [Authorize]
    public class BaseCRUDController<T, TSearch, TInsert, TUpdate> : BaseController<T, TSearch> where T : class where TSearch : class where TInsert : class where TUpdate : class
    {
        protected new readonly IBaseCRUDService<T, TSearch, TInsert, TUpdate> _service;
        public BaseCRUDController(IBaseCRUDService<T, TSearch, TInsert, TUpdate> service) : base(service)
        {
            _service = service;
        }

        [HttpPost]
        public virtual T Insert([FromBody] TInsert insert)
        {
            return _service.Insert(insert);
        }

        [HttpPut("{id}")]
        public virtual T Update(int id, [FromBody] TUpdate update)
        {
            return _service.Update(id, update);
        }

        [HttpDelete("{id}")]
        public virtual T Delete(int id)
        {
            return _service.Delete(id);
        }
    }
}