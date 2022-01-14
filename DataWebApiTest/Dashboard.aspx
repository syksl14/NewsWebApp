<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="DataWebApiTest.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
    <script src="Framework/js/script.js"></script>
    <link href="Framework/css/style.css" rel="stylesheet" />
    <link href="css/messagebox.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <script src="scripts/messagebox.min.js"></script>
    <script src="Framework/js/script.js"></script>
    <script src="scripts/site.js"></script>
</head>
<body>
    <%
        String[] x = SYuksel.WebFramework.GetSingleData("SELECT Ad,Soyad FROM KULLANICILAR_V WHERE KullaniciGuid= @KullaniciGuid", Session["KullaniciGuid"].ToString()).Split('~');
        if (x.Length > 0)
        {
    %>
    <div class="wallpaper"></div>
    <header>
        <div style="width: 350px; float: left;">
            Merhaba, <b><%= x[0] %></b> çıkış yap için <a href="javascript:kullanici.cikisyap();">buraya tıklayın.</a>
        </div>
        <div style="width: 300px; text-align: right; float: right; text-transform: uppercase;">
            <%= x[0] %> <%= x[1] %>
        </div>
    </header>
      <div id="loading">
            <img src="css/imgs/loading.gif" />
            <label>Yükleniyor...</label>
        </div>
    <div class="main">
      
    </div>
    <div class="islemler"></div>
    <% } %>
    <script>
        $(function () {
            dashboard.init();
        });
    </script>
</body>
</html>
