using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataWebApiTest.Admin
{
    public partial class DuzenleYeni : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["KullaniciGuid"] != null)
            {
                htmlControlHaber.SQL = "SELECT * FROM Haberler WHERE HaberID= @HaberID";
                htmlControlHaber.SQLParams[0] = Request.QueryString["id"];
            }
        }
    }
}