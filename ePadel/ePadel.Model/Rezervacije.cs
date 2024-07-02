using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model
{
    public class Rezervacije
    {
        public int RezervacijaId { get; set; }
        public int? KorisnikId { get; set; }
        public int? TerenId { get; set; }
        public int? Cijena { get; set; }
        public string? RezervacijaStatus { get; set; }
        public string? DatumRezervacije { get; set; }
        public string? VrijemeRezervacije { get; set; }
        public string? PotrebnaReketa { get; set; }
        public int? BrojReketa { get; set; }
        //public string PaymentMethod
        //{
        //    get { return PlatiTermin.PaymentMethod; }
        //}
        public string? TerenNaziv
        {
            get
            {
                return Teren?.Naziv;
            }
        }
        public string? KorisnickoIme
        {
            get
            {
                return Korisnik?.KorisnickoIme;
            }
        }
        public virtual Korisnik? Korisnik { get; set; }
        public virtual Tereni? Teren { get; set; }
        public virtual PlatiTermin? PlatiTermin { get; set; }


        //public virtual ICollection<Plaćanja>? Plaćanjas { get; set; }
    }
}
