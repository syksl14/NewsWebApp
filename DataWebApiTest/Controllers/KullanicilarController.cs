using DataWebApiTest.Models;
using DataWebApiTest.Models.Views;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using SYuksel;

namespace DataWebApiTest.Controllers
{
    public class KullanicilarController : ApiController
    {
        Response response = new Response();
        [Route("api/kullanici/giris")]
        [HttpPost]
        public IHttpActionResult KullaniciGiris(Kullanicilar kullanici)
        {
            var kullanicilar = WebFramework.GetData<KULLANICILAR_V>("SELECT * FROM KULLANICILAR_V WHERE Email= @Email AND Sifre= @Sifre", kullanici.Email, kullanici.Sifre);
            List<KULLANICILAR_V> veri = kullanicilar.Cast<KULLANICILAR_V>().ToList();
            if (veri.Count > 0)
            {
                HttpContext.Current.Session["TokenID"] = veri[0].TokenID;
                HttpContext.Current.Session["KullaniciGuid"] = veri[0].KullaniciGuid;
                response.message = "OK";
            }
            else
            {
                response.message = "false";
            }
            return Ok(response);
        }

        [Route("api/kullanici/cikis")]
        [HttpPost]
        public IHttpActionResult KullaniciCikis()
        {
            HttpContext.Current.Session["TokenID"] = null;
            HttpContext.Current.Session["KullaniciGuid"] = null;
            response.message = "OK";
            return Ok(response);
        }
        [Route("api/kullanici/session/kontrol")]
        [HttpPost]
        public IHttpActionResult KullaniciSessionKontrol()
        {
            if (HttpContext.Current.Session["KullaniciGuid"] != null)
            {
                response.message = "OK";
            }
            else
            {
                response.message = "false";
            }
            return Ok(response);
        }
    }        
}
