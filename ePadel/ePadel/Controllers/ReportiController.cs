using ePadel.Model;
using ePadel.Model.Requests.FeedbackRequest;
using ePadel.Model.Requests.ReportiRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.FeedbackService;
using ePadel.Services.ReportiService;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [Route("[controller]")]
    public class ReportiController : BaseCRUDController<Reporti, BaseSearchObject, ReportiInsertRequest, object>
    {
        protected IReportiService _reportiService { get; set; }
        public ReportiController(IReportiService service) : base(service)
        {
            _reportiService = service;
        }
        [HttpGet("reporti")]
        public async Task<Reporti> GetReservationTimeSlots(int? terenId, string godina)
        {
            return await _reportiService.GetReporti(terenId, godina);
        }
    }

}
