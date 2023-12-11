using AutoMapper;
using ePadel.Model.SearchObjects;
using ePadel.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.BaseService
{
    public class BaseService<T, TDb, TSearch> : IBaseService<T, TSearch> where TDb : class where T : class where TSearch : BaseSearchObject
    {
        protected IB190069_ePadelContext _context;
        protected IMapper _mapper { get; set; }
        public BaseService(IB190069_ePadelContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public virtual IEnumerable<T> GetAll(TSearch? search = null)
        {
            var entity = _context.Set<TDb>().AsQueryable();
            entity = AddFilter(entity, search);
            entity = AddInclude(entity, search);
            var list = entity.ToList();
            return _mapper.Map<IList<T>>(list);
        }

        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch search = null)
        {
            return query;
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch search = null)
        {
            return query;
        }

        public virtual T GetById(int id)
        {
            var set = _context.Set<TDb>();

            var entity = set.Find(id);

            return _mapper.Map<T>(entity);
        }
    }
}



