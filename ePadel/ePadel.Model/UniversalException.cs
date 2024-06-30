using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model
{
    public  class UniversalException: System.Exception
    {
        public string Title { get; set; }
        public UniversalException(string title, string message) : base(message)
        {
            Title = title;
        }
    }
}
