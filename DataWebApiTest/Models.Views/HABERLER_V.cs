using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DataWebApiTest.Models.Views
{
    public class HABERLER_V
    {
        public int KaynakID { get; set; }
        public int HaberID { get; set; }
        public int Okunma { get; set; }
        public String KullaniciGuid { get; set; }
        public String Ad { get; set; }
        public String Soyad { get; set; }
        public String Baslik { get; set; }
        public String Ozet { get; set; }
        public String Resim { get; set; }
        public String URL { get; set; }
        public String EklenmeTarihi { get; set; }
        public int Yayinlandi { get; set; }
        public String Kaynak { get; set; }
    }
}