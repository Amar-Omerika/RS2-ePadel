using ePadel.Services.SpoloviService;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [Route("[controller]")]
    public class SpoloviController : BaseController<Model.Spol, Model.SearchObjects.BaseSearchObject>
    {
        public SpoloviController(ISpoloviService service) : base(service)
        {
        }
    }
}
