using ePadel.Model.SearchObjects;
using ePadel.Services.Database;
using ePadel.Services.Gradovi;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [Route("[controller]")]
    public class GradoviController : BaseController<Model.Grad, Model.SearchObjects.BaseSearchObject>
    {
        public GradoviController(IGradoviService service) : base(service)
        {
        }
    }
}
