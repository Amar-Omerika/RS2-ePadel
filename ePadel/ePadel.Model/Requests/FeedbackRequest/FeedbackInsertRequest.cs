using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.Requests.FeedbackRequest
{
    public class FeedbackInsertRequest
    {
        public string Komentar { get; set; }
        public int? KorisnikId { get; set; }
    }
}
