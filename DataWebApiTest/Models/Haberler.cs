using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SYuksel;

namespace DataWebApiTest.Models
{
    public class Haberler
    {
        [Column("Identity")]
        public int HaberID { get; set; }
        public String Baslik { get; set; }
        public String Ozet { get; set; }
        public String URL { get; set; }
        public String Resim { get; set; }
        public DateTime EklenmeTarihi { get; set; }
        public int KaynakID { get; set; }
        public int Okunma { get; set; }
        public Boolean Yayinlandi { get; set; }
        public String EkleyenGuid { get; set; }
    }
}