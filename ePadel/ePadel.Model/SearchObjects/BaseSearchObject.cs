using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Model.SearchObjects
{
    public class BaseSearchObject
    {
        public string? Tekst { get; set; }
        public int? Page { set; get; }
        public int? PageSize { get; set; }

    }
}
