﻿using ePadel.Model;
using ePadel.Model.Requests.RezervacijaRequest;
using ePadel.Model.Requests.TerenRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.RezervacijaService;
using ePadel.Services.TerenService;
using Microsoft.AspNetCore.Mvc;

namespace ePadel.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RezervacijaController : BaseCRUDController<Model.Rezervacije, RezervacijaSearchObject, RezervacijaInsertRequest, RezervacijaUpdateRequest>
    {
        protected IRezervacijaService? _service { get; set; }
        public RezervacijaController(IRezervacijaService service) : base(service)
        {
            _service = service;
        }
        [HttpGet("GetSlotsByDate")]

        public List<string> GetTimeSlotsForDate(int terenId, string datumRezervacije)
        {
            return _service.getSlotsForReservationDate(terenId, datumRezervacije);
        }


        [HttpGet("HistoryReservations")]
        public async Task<PagedResult<Rezervacije>> History(int korisnikId)
        {
            return await _service.HistoryReservations(korisnikId);
        }
        public override Model.Rezervacije Insert([FromBody] RezervacijaInsertRequest request)
        {
            return base.Insert(request);
        }

        public override Model.Rezervacije Update(int id, [FromBody] RezervacijaUpdateRequest request)
        {
            return base.Update(id, request);
        }
    }
}
