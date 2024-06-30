using AutoMapper;
using ePadel.Model.Exception;
using ePadel.Model.Requests.FeedbackRequest;
using ePadel.Model.Requests.KorisnikRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.FeedbackService
{
    public class FeedbackService : BaseCRUDService<Model.Feedback, Database.Feedback, BaseSearchObject, FeedbackInsertRequest, object>, IFeedbackService
    {
        public FeedbackService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override void BeforeInsert(FeedbackInsertRequest insert, Database.Feedback entity)
        {
            if (insert == null)
            {
                throw new FeedbackException("Feedback ne posjeduje vrijednost!");
            }

            if (string.IsNullOrWhiteSpace(insert.Komentar))
            {
                throw new FeedbackException("Feedback ne smije biti prazan!");
            }

            if (insert.KorisnikId == null)
            {
                throw new FeedbackException("Feedback mora sadržati korisnika!");
            }

            var user = _context.Korisniks.Find(insert.KorisnikId);

            if (user == null)
            {
                throw new FeedbackException("Korisnik ne postoji!");
            }

            if (insert.Komentar.Length < 1 || insert.Komentar.Length > 150)
            {
                throw new FeedbackException("Feedback mora imati više od 0, a manje od 150 karaktera!");
            }

            var feedback = _context.Feedbacks.Where(x => x.KorisnikId == insert.KorisnikId).FirstOrDefault();

            if (feedback != null)
            {
                throw new FeedbackException("Feedback možete postaviti samo jednom!");
            }

            base.BeforeInsert(insert, entity); 
        }
    }
}
