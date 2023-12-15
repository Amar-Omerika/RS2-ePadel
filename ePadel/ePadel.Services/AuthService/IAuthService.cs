using ePadel.Model.Requests.KorisnikRequest;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.AuthService
{
    public interface IAuthService
    {
        public Task<Model.Korisnik> Register(KorisnikInsertRequest request);
        public Task<Model.Korisnik> Login(LoginRequest request);
        public Task<Model.Korisnik> LoginAdmin(LoginRequest request);
    }
}
