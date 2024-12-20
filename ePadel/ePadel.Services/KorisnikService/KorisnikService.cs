﻿using AutoMapper;
using ePadel.Model;
using ePadel.Model.Enums;
using ePadel.Model.Requests.KorisnikRequest;
using ePadel.Model.SearchObjects;
using ePadel.Services.BaseService;
using ePadel.Services.Database;
using Microsoft.EntityFrameworkCore;

namespace ePadel.Services.KorisnikService
{
    public class KorisnikService : BaseCRUDService<Model.Korisnik, Database.Korisnik, KorisnikSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>, IKorisnikService
    {
        public KorisnikService(IB190069_ePadelContext context, IMapper mapper) : base(context, mapper)
        {

        }
        public override IQueryable<Database.Korisnik> AddInclude(IQueryable<Database.Korisnik> query, KorisnikSearchObject search = null)
        {
            query = query.Include(x => x.KorisnikUloges);
            return base.AddInclude(query, search);
        }

    public override IQueryable<Database.Korisnik> AddFilter(IQueryable<Database.Korisnik> query, KorisnikSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            if (!string.IsNullOrWhiteSpace(search?.Tekst))
                filteredQuery = filteredQuery.Where(x => x.KorisnickoIme.ToLower().Contains(search.Tekst.ToLower()));
            //specific case where I needed to retrieve from database string value of the enum and mapped it to the model, adjusted search also
            if (!string.IsNullOrWhiteSpace(search?.Spol))
            {
                if (Enum.TryParse<Spol>(search.Spol, true, out var spolEnum))
                {
                    filteredQuery = filteredQuery.Where(x => x.Spol == spolEnum);
                    if (!filteredQuery.Any())
                    {
                        return _context.Korisniks.Where(x => false); // Return an empty query
                    }
                }
                else
                {
                    // Handle invalid Spol value if necessary
                    return _context.Korisniks.Where(x => false); // Return an empty query
                }
            }
            return filteredQuery;
        }

        public override void BeforeInsert(KorisnikInsertRequest insert, Database.Korisnik entity)
        {
            var salt = Helper.PasswordHelper.GenerateSalt();
            entity.LozinkaSalt = salt;
            entity.LozinkaHash = Helper.PasswordHelper.GenerateHash(salt, insert.Password);
            base.BeforeInsert(insert, entity);
        }

        public override Model.Korisnik Insert(KorisnikInsertRequest request)
        {
            var korisnici = _context.Set<Database.Korisnik>().AsQueryable();

            if (korisnici.Any(x => x.KorisnickoIme == request.KorisnickoIme))
            {
                throw new KorisnikException("Korisnicko ime vec postoji", "Postoji korisnik sa tim korisnickim imenom!");
            }

            var entity = base.Insert(request);

            foreach (var role in request.Uloge)
            {
                Database.KorisnikUloge korisnikUloge = new Database.KorisnikUloge
                {
                    KorisnikId = entity.KorisnikId,
                    UlogaId = role
                };
                _context.KorisnikUloges.Add(korisnikUloge);
            }

            _context.SaveChanges();

            return entity;
        }
        public override Model.Korisnik Update(int id, KorisnikUpdateRequest request)
        {
            var entity = _context.Korisniks.Find(id);
            var korisnikUloge = _context.KorisnikUloges.Where(e => e.KorisnikId == id).ToList();

            if (korisnikUloge.Any(ku => ku.UlogaId == 1))
            {
                throw new KorisnikException("Editovanje korisnika", "Nije moguce editovati korisnika jer ima Admin privilegiju");
            }
            var korisnikSaKorisnickimImenom = _context.Korisniks.Where(x => x.KorisnikId != id && x.KorisnickoIme == request.KorisnickoIme).ToList();
            if (korisnikSaKorisnickimImenom != null && korisnikSaKorisnickimImenom.Count > 0)
            {
                throw new KorisnikException("Korisničko ime", "Korisničko ime već postoji!");
            }
            return base.Update(id, request);
        }
        public Model.Korisnik GetByUsername(string korisnickoIme)
        {
            var korisnik = _context.Korisniks.Where(x => x.KorisnickoIme == korisnickoIme).FirstOrDefault();
            return _mapper.Map<Model.Korisnik>(korisnik);
        }
        public override Model.Korisnik Delete(int id)
        {
            var entity = _context.Korisniks.Find(id);
            var korisnikUloge = _context.KorisnikUloges.Where(e => e.KorisnikId == id).ToList();

            if (korisnikUloge.Any(ku => ku.UlogaId == 1))
            {
                throw new KorisnikException("Brisanje korisnika", "Nije moguce obrisati korisnika jer ima Admin privilegiju");
            }

            if (korisnikUloge != null && korisnikUloge.Any())
            {
                foreach (var ulogaUloge in korisnikUloge)
                {
                    _context.KorisnikUloges.Remove(ulogaUloge);
                }
            }

            if (entity != null)
            {
                _context.Korisniks.Remove(entity);
            }

            _context.SaveChanges();
            return _mapper.Map<Model.Korisnik>(entity);
        }

    }
}
