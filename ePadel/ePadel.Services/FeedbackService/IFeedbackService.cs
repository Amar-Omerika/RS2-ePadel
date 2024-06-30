using ePadel.Model;
using ePadel.Model.Requests.FeedbackRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.FeedbackService
{
    public interface IFeedbackService : IBaseCRUDService<Feedback, BaseSearchObject, FeedbackInsertRequest, object>
    {
    }
}
