using ePadel.Model;
using ePadel.Model.Requests.FeedbackRequest;
using ePadel.Model.Requests.KorisnikRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.FeedbackService;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [Route("[controller]")]
    public class FeedbackController : BaseCRUDController<Feedback, BaseSearchObject, FeedbackInsertRequest, object>
    {
        public FeedbackController(IFeedbackService service) : base(service)
        {
        }
    }

}
