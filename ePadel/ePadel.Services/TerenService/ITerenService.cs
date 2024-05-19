using ePadel.Model.Requests.TerenRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;


namespace ePadel.Services.TerenService
{
    public interface ITerenService : IBaseCRUDService<Model.Tereni,TerenSearchObject,TerenInsertRequest,TerenUpdateRequest> 
    {
        public List<Model.Tereni> TereniRecommendedSystem();
    }
 
}
