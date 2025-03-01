﻿using AutoMapper;
using ePadel.Model.Requests.FeedbackRequest;
using ePadel.Model.Requests.KorisnikRequest;
using ePadel.Model.Requests.KorisnikUlogeRequest;
using ePadel.Model.Requests.ObavijestiRequest;
using ePadel.Model.Requests.OcjeneRequest;
using ePadel.Model.Requests.PartneriRequest;
using ePadel.Model.Requests.PlatiRequest;
using ePadel.Model.Requests.ReportiRequest;
using ePadel.Model.Requests.RezervacijaRequest;
using ePadel.Model.Requests.TerenRequest;
using ePadel.Model.Requests.TipTerenaRequest;
using ePadel.Model.Requests.TrenerRequest;
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
            CreateMap<Database.Korisnik, Model.Korisnik>()
                .ForMember(dest => dest.SpolString, opt => opt.MapFrom(src => src.Spol.ToString()));
            CreateMap<Database.Korisnik, Model.Korisnik>();
            CreateMap<Database.KorisnikUloge, Model.KorisnikUloge>();
            CreateMap<Database.Uloga, Model.Uloga>();
            CreateMap<Database.Gradovi, Model.Grad>();
            CreateMap<Database.Tereni, Model.Tereni>();
            CreateMap<Database.TipTerena, Model.TipTerena>();
            CreateMap<Database.Rezervacije, Model.Rezervacije>();
            CreateMap<Database.PlatiTermin, Model.PlatiTermin>();
            CreateMap<Database.Feedback, Model.Feedback>();
            CreateMap<Database.Ocjene, Model.Ocjene>();
            CreateMap<Database.Reporti, Model.Reporti>();
            CreateMap<Database.Obavijesti, Model.Obavijesti>();
            CreateMap<Database.Partneri, Model.Partneri>();
            CreateMap<Database.Treneri, Model.Treneri>();







            CreateMap<KorisnikInsertRequest, Database.Korisnik>();
            CreateMap<KorisnikUpdateRequest, Database.Korisnik>();
            CreateMap<KorisnikUlogeInsertRequest, Database.KorisnikUloge>();

            CreateMap<TerenInsertRequest, Database.Tereni>();
            CreateMap<TerenUpdateRequest, Database.Tereni>();

            CreateMap<TipTerenaInsertRequest, Database.TipTerena>();
            CreateMap<TipTerenaUpdateRequest, Database.TipTerena>();

            CreateMap<RezervacijaInsertRequest, Database.Rezervacije>();
            CreateMap<RezervacijaUpdateRequest, Database.Rezervacije>();

            CreateMap<PlatiInsertRequest, Database.PlatiTermin>();

            CreateMap<FeedbackInsertRequest, Database.Feedback>();

            CreateMap<OcjeneInsertRequest, Database.Ocjene>();

            CreateMap<ReportiInsertRequest, Database.Reporti>();

            CreateMap<ObavijestiInsertRequest, Database.Obavijesti>();
            CreateMap<ObavijestiUpdateRequest, Database.Obavijesti>();

            CreateMap<PartneriInsertRequest, Database.Partneri>();
            CreateMap<PartneriUpdateRequest, Database.Partneri>();

            CreateMap<TrenerInsertRequest, Database.Treneri>();
            CreateMap<TrenerUpdateRequest, Database.Treneri>();









        }

    }
}
