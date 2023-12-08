using AutoMapper;
using ePadel.Model.Requests.KorisnikRequest;
using ePadel.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.KorisnikService
{
    public class KorisnikService : IKorisnikService
    {
        IB190069_ePadelContext _context;
        public IMapper _mapper { get;set; }
        public KorisnikService(IB190069_ePadelContext context,IMapper mapper)
        {
            _context = context;
            _mapper= mapper;
        }
        public List<Model.Korisnik> Get()
        {
            var entityList= _context.Korisniks.ToList();
            //var list = new List<Model.Korisnik>();
            //foreach (var item in entityList) {
            //  list.Add(new Model.Korisnik() { Email = item.Email, Ime = item.Ime, KorisnickoIme = item.KorisnickoIme,Prezime=item.Prezime,KorisnikId=item.KorisnikId});
            //}
            //return list;
            return _mapper.Map<List<Model.Korisnik>>(entityList);
        }
        public Model.Korisnik Insert(KorisnikInsertRequest request)
        {
            var entity = new Korisnik();
            _mapper.Map(request, entity);

            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt,request.Password);

            _context.Korisniks.Add(entity);
            _context.SaveChanges();

            return _mapper.Map<Model.Korisnik>(entity);
        }
        public static string GenerateHash(string salt, string lozinka)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(lozinka);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

        public static string GenerateSalt()
        {
            var buf = new byte[16];
            (new RNGCryptoServiceProvider()).GetBytes(buf);
            return Convert.ToBase64String(buf);
        }

        public Model.Korisnik Update(int id,KorisnikUpdateRequest request)
        {
            var entity = _context.Korisniks.Find(id);

            //mapira sa objekta request na nas entitet
            _mapper.Map(request, entity);

            _context.SaveChanges();

            //ovdje vratimo samo nas entitet
            return _mapper.Map<Model.Korisnik>(entity);
        }
    }
}
