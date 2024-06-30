using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.Exception
{
    public class FeedbackException : System.Exception
    {
        public FeedbackException(string message)
            : base(message)
        {
        }
    }
}
