using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.Mapping
{
    public class MappingProfile:Profile
    {
        public MappingProfile() {
            CreateMap<Database.Korisnik, Model.Korisnik>();
            CreateMap<Model.Requests.KorisnikRequest.KorisnikInsertRequest, Database.Korisnik>();
            CreateMap<Model.Requests.KorisnikRequest.KorisnikUpdateRequest, Database.Korisnik>();
        }
       
    }
}
