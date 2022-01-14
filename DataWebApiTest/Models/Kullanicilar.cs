using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DataWebApiTest.Models
{
    public class Kullanicilar
    {
        public String KullaniciGuid { get; set; }
        public String Ad { get; set; }
        public String Soyad { get; set; }
        public String Email { get; set; }
        public String Sifre { get; set; }
    }
}