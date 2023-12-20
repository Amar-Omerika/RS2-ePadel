using AutoMapper;
using ePadel.Model.Requests.KorisnikRequest;
using ePadel.Model.Requests.KorisnikUlogeRequest;
using ePadel.Model.Requests.RezervacijaRequest;
using ePadel.Model.Requests.TerenRequest;
using ePadel.Model.Requests.TipTerenaRequest;
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
            CreateMap<Database.KorisnikUloge, Model.KorisnikUloge>();
            CreateMap<Database.Uloga, Model.Uloga>();
            CreateMap<Database.Tereni, Model.Tereni>();
            CreateMap<Database.TipTerena, Model.TipTerena>();
            CreateMap<Database.KorisničkePreferencije, Model.KorisničkePreferencije>();
            CreateMap<Database.Rezervacije, Model.Rezervacije>();
            CreateMap<Database.RezervacijaStatusi, Model.RezervacijaStatusi>();
            CreateMap<Database.Termini, Model.Termini>();
            CreateMap<Database.Ocijene, Model.Ocijene>();





            CreateMap<KorisnikInsertRequest, Database.Korisnik>();
            CreateMap<KorisnikUpdateRequest, Database.Korisnik>();
            CreateMap<KorisnikUlogeInsertRequest, Database.KorisnikUloge>();

            CreateMap<TerenInsertRequest, Database.Tereni>();
            CreateMap<TerenUpdateRequest, Database.Tereni>();

            CreateMap<TipTerenaInsertRequest, Database.TipTerena>();
            CreateMap<TipTerenaUpdateRequest, Database.TipTerena>();

            CreateMap<RezervacijaInsertRequest, Database.Rezervacije>();
            CreateMap<RezervacijaUpdateRequest, Database.Rezervacije>();
        }
       
    }
}
