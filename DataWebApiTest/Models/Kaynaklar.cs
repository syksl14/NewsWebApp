using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DataWebApiTest.Models
{
    public class Kaynaklar
    {
        public int KaynakID { get; set; }
        public String Kaynak { get; set; }
        public String WebSite { get; set; }
        public String Email { get; set; }
    }
}