using ePadel.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.PadelTerenService
{
    public  interface IPadelTerenService
    {
        IList<PadelTeren> Get();
    }
}
