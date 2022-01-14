using DataWebApiTest.Models;
using DataWebApiTest.Models.Views;
using SimpleFeedReader;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.UI.WebControls;
using SYuksel;

namespace DataWebApiTest.Controllers
{
    public class HaberlerController : ApiController
    {

        [Route("api/haberler/{token}")]
        [HttpGet]
        public IHttpActionResult HaberleriGetir(String token)
        {
            List<HABERLER_V> haberler = new List<HABERLER_V>();
            if (TokenCheck(token))
            {
                var x = WebFramework.GetData<HABERLER_V>
            ("SELECT HaberID, Baslik, Ozet, Kaynak, Okunma, Yayinlandi, EklenmeTarihi, Resim FROM HABERLER_V ORDER BY HaberID DESC");
                haberler = x.Cast<HABERLER_V>().ToList();
                return Ok(haberler);
            }
            else
            {
                return Unauthorized();
            }
        }
        [Route("api/haberler/tara")]
        [HttpGet]
        public IHttpActionResult HaberTarama()
        {
            List<Haberler> haberler = new List<Haberler>();
            var reader = new FeedReader();
            var items = reader.RetrieveFeed("http://shiftdelete.net/rss/");

            foreach (var i in items)
            {
                Haberler haber = new Haberler();
                haber.Baslik = i.Title;
                haber.Ozet = i.Summary;
                haber.URL = i.Uri.ToString();
                haber.Resim = "";
                haber.EklenmeTarihi = i.Date.Date;
                haberler.Add(haber);
            }
            return Ok(haberler);
        }

        [Route("api/haberler/haber/{id}/{token}")]
        [HttpGet]
        public IHttpActionResult HaberGetir(int id, String token)
        {
            if (TokenCheck(token))
            {
                var x = WebFramework.GetData<HABERLER_V>
              ("SELECT Baslik, Ozet, Kaynak, Okunma, URL, Ad, Soyad, EklenmeTarihi, Resim FROM HABERLER_V WHERE HaberID= @HaberID", id);
                List<HABERLER_V> haberler = x.Cast<HABERLER_V>().ToList();
                if (haberler.Count > 0)
                {
                    return Ok(haberler[0]);
                }
                else
                {
                    return NotFound();
                }
            }
            else
            {
                return Unauthorized();
            }
        }
        [Route("api/haberler/haber/ekle")]
        [HttpPost]
        public IHttpActionResult HaberEkle(Models.Haberler haber)
        {
            if (HttpContext.Current.Session["KullaniciGuid"] != null)
            {
                haber.Okunma = 0;
                haber.EkleyenGuid = HttpContext.Current.Session["KullaniciGuid"].ToString();
                haber.EklenmeTarihi = DateTime.Now;
                String id = WebFramework.InsertDataIdentity(haber).ID.ToString();
                haber.HaberID = Convert.ToInt32(id);
                return Ok(haber);
            }
            else
            {
                return Unauthorized();
            }
        }
        [Route("api/haberler/haber/kaydet")]
        [HttpPost]
        public IHttpActionResult HaberKaydet(Models.Haberler haber)
        {
            if (HttpContext.Current.Session["KullaniciGuid"] != null)
            {
                Response response = new Response();
                String SQL = "UPDATE Haberler SET "
                  + " Baslik= @Baslik, "
                  + "Ozet= @Ozet, "
                  + "URL= @URL, "
                  + "Resim= @Resim, "
                  + "KaynakID= @KaynakID, "
                  + "Yayinlandi= @Yayinlandi WHERE HaberID= @HaberID";
                WebFramework.ExecuteNonQuery(SQL, haber.Baslik, haber.Ozet, haber.URL, haber.Resim, haber.KaynakID, haber.Yayinlandi, haber.HaberID);
                response.message = "OK";
                return Ok(response);
            }
            else
            {
                return Unauthorized();
            }
        }
        [Route("api/haberler/haber/sil")]
        [HttpPost]
        public IHttpActionResult HaberSil(Models.Haberler haber)
        {
            if (HttpContext.Current.Session["KullaniciGuid"] != null)
            {
                Response response = new Response();
                WebFramework.ExecuteNonQuery("DELETE FROM Haberler WHERE HaberID= @HaberID", haber.HaberID);
                response.message = "OK";
                return Ok(response);
            }
            else
            {
                return Unauthorized();
            }
        }
        Boolean TokenCheck(String token)
        {
            Boolean result = false;
            if (HttpContext.Current.Session["TokenID"] != null)
            {
                token = HttpContext.Current.Session["TokenID"].ToString();
            }
            var x = WebFramework.GetData<ApiTokens>("SELECT CONVERT (nvarchar(50), TokenID) AS TokenID, "
          + " CONVERT (nvarchar(50), KullaniciGuid) AS KullaniciGuid FROM ApiTokens WHERE TokenID= @TokenID", token);
            List<ApiTokens> tokens = x.Cast<ApiTokens>().ToList();
            if (tokens.Count > 0)
            {
                result = true;
            }
            return result;
        }
    }
}
