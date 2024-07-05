using System.ComponentModel.DataAnnotations;

namespace ePadel.Model.Requests.KorisnikRequest
{
    public class KorisnikInsertRequest
    {
        public string? Ime { get; set; }

        public string? Prezime { get; set; }


        [Required(AllowEmptyStrings = false)]
        [MinLength(4, ErrorMessage = "Korisničko ime mora sadržavati najmanje 4 karaktera!")]
        public string? KorisnickoIme { get; set; }


        [Required(AllowEmptyStrings = false)]
        [EmailAddress()]
        public string? Email { get; set; }

        [Required]
        [MinLength(8, ErrorMessage = "Lozinka mora sadržavati najmanje 8 karaktera!")]
        public string? Password { get; set; }

        [Required(ErrorMessage = "Spol je obavezan.")]
        public int SpoloviId { get; set; }

        [Required(ErrorMessage = "Dominantna ruka je obavezna.")]
        public string? DominantnaRuka { get; set; }

        public string? PasswordPotvrda { get; set; }
        public string? Slika { get; set; }
        public List<int>? Uloge { get; set; } = new List<int>();
        public bool? Aktivan { get; set; }
    }
}
