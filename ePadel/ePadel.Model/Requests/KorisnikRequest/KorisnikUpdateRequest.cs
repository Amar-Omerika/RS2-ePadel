using System.ComponentModel.DataAnnotations;

namespace ePadel.Model.Requests.KorisnikRequest
{
    public class KorisnikUpdateRequest
    {
        public string? Ime { get; set; }

        public string? Prezime { get; set; }

        [Required(AllowEmptyStrings = false)]
        [EmailAddress()]
        public string? Email { get; set; }


        [Required(AllowEmptyStrings = false)]
        [MinLength(4)]
        public string? KorisnickoIme { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string? Spol { get; set; }

        public string? DominantnaRuka { get; set; }

        public bool? Aktivan { get; set; }
    }
}
