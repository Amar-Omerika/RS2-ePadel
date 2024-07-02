using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.Exception
{
    public class OcjeneException : System.Exception
    {
        public OcjeneException(string message)
           : base(message)
        {
        }
    }
}
