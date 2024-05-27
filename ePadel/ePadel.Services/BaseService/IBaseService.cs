using ePadel.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.BaseService
{
    public interface IBaseService<T, TSearch> where T : class where TSearch : class
    {
        Task<PagedResult<T>> Get(TSearch search = null);
        T GetById(int id);
    }
}
