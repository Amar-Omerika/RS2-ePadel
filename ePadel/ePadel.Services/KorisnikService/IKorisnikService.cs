using ePadel.Model.Requests.KorisnikRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;


namespace ePadel.Services.KorisnikService
{
    public interface IKorisnikService : IBaseCRUDService<Model.Korisnik, KorisnikSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        Model.Korisnik GetByUsername(string korisnickoIme);
       
    }
}
