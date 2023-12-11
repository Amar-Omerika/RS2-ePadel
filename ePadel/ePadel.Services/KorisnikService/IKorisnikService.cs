using ePadel.Model.Requests.KorisnikRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.KorisnikService
{
    public interface IKorisnikService : IBaseCRUDService<Model.Korisnik, BaseSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        Model.Korisnik GetByUsername(string korisnickoIme);
       
    }
}
