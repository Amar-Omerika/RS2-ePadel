using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model
{
    public class KorisnikException : System.Exception
    {
        public string Title { get; set; }
        public KorisnikException(string title, string message) : base(message)
        {
            Title = title;
        }
    }
}
