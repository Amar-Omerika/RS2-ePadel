using AutoMapper;
using ePadel.Model;
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

        public virtual async Task<PagedResult<T>> Get(TSearch? search = null)
        {
            var query = _context.Set<TDb>().AsQueryable();

            PagedResult<T> result = new PagedResult<T>();

            result.TotalCount = await query.CountAsync();


            if (typeof(TDb) == typeof(Database.Tereni))
            {
                var queryReservation = query as IQueryable<Database.Tereni>;

                if (queryReservation != null)
                {
                    result.TotalCount = await queryReservation.CountAsync();
                }
            }

            if (typeof(TDb) == typeof(Database.Korisnik))
            {
                var queryReservation = query as IQueryable<Database.Korisnik>;

                if (queryReservation != null)
                {
                    result.TotalCount = await queryReservation.CountAsync();
                }
            }

         
            query = AddFilter(query, search);

            query = AddInclude(query, search);

            result.Count = await query.CountAsync();

            if (typeof(TDb) == typeof(Database.Rezervacije))
            {
                var queryReservation = query as IQueryable<Database.Rezervacije>;

                if (queryReservation != null)
                {
                    result.TotalCount = await queryReservation.CountAsync();

                    result.UkupanBrojReketa = await queryReservation.SumAsync(x => x.BrojReketa);
                }
            }
            else
            {
                result.UkupanBrojReketa = 0;
            }

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip(search.Page.Value * search.PageSize.Value).Take(search.PageSize.Value);
            }

            var list = await query.ToListAsync();


            var tmp = _mapper.Map<List<T>>(list);
            result.Result = tmp;
            return result;
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



