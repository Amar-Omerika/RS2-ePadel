using ePadel.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.Database
{
    public class Feedback
    {
        public int FeedbackId { get; set; }

        public string Komentar { get; set; }

        public int KorisnikId { get; set; }

        public Korisnik Korisnik { get; set; }
    }
}
