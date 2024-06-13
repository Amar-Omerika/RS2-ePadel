using AutoMapper;
using ePadel.Model.Requests.PlatiRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using ePadel.Services.PaymentService;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.PlatiService
{
    public class PlatiService : BaseCRUDService<Model.PlatiTermin, Database.PlatiTermin, BaseSearchObject, PlatiInsertRequest, PlatiInsertRequest>, IPlatiService
    {
        public StripeService _stripeService { get; set; }
        public PlatiService(IB190069_ePadelContext context, IMapper mapper, StripeService stripeService) : base(context, mapper)
        {
            _stripeService= stripeService;
        }

        public override IQueryable<ePadel.Services.Database.PlatiTermin> AddInclude(IQueryable<ePadel.Services.Database.PlatiTermin> query, BaseSearchObject search = null)
        {
            query = query.Include(x => x.Korisnik).Include(x => x.Termin);
            return base.AddInclude(query, search);
        }

        public override Model.PlatiTermin Insert(PlatiInsertRequest request)
        {
           
            PlatiTermin platitermin = new PlatiTermin();
            platitermin.KorisnikId = (int)request.KorisnikId;
            platitermin.DatumKupovine = DateTime.Now;
            platitermin.Cijena = request.Cijena;
            platitermin.Placena = true;
            _context.Add(platitermin);
            _context.SaveChanges();

            var paymentId = _stripeService.PlatiTermin(platitermin.Cijena, $"Kupovina za ({platitermin.DatumKupovine})");
            platitermin.PaymentIntentId = paymentId;
            _context.SaveChanges();
            return _mapper.Map<Model.PlatiTermin>(platitermin);
        }
    }
}
