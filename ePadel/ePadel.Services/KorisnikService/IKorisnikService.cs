using ePadel.Model.Requests.KorisnikRequest;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.KorisnikService
{
    public interface IKorisnikService
    {
        List<Model.Korisnik> Get();
        Model.Korisnik Insert(KorisnikInsertRequest request);
        Model.Korisnik Update(int id,KorisnikUpdateRequest request);
    }
}
