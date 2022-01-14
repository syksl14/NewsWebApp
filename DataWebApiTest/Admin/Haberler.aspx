<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Haberler.aspx.cs" Inherits="DataWebApiTest.Admin.Haberler" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <% if (Session["KullaniciGuid"] != null)
        { %>
    <div style="height: 500px; overflow-x: auto;">
        <button type="button" onclick="haberler.yeni();">Yeni Haber</button>
        <button type="button" onclick="haberler.secilenlerisil();">Seçili Haberleri Sil</button>
        <table id="tblHaberler" border="0">
            <thead>
                <tr>
                    <td style="text-align: center;">
                        <input type="checkbox" onchange="haberler.tumunusec(this);" /></td>
                    <td>Başlık</td>
                    <td>Okunma</td>
                    <td>Yayınlandı</td>
                    <td>Eklenme Tarihi</td>
                    <td>Kaynak</td>
                    <td>Ekleyen</td>
                    <td>İşlem</td>
                </tr>
            </thead>
            <tbody>
                <%
                    List<DataWebApiTest.Models.Views.HABERLER_V> haberler = SYuksel.WebFramework.GetData<DataWebApiTest.Models.Views.HABERLER_V>("SELECT * FROM HABERLER_V ORDER BY HaberID DESC").ToList();
                    foreach (DataWebApiTest.Models.Views.HABERLER_V haber in haberler)
                    {
                %>
                <tr data-id="<%= haber.HaberID %>">
                    <td style="text-align: center;">
                        <input type="checkbox" class="haberchkbox" onchange="haberler.habersec(this);" />
                    </td>
                    <td><%= haber.Baslik %></td>
                    <td><%= haber.Okunma %></td>
                    <td><%= haber.Yayinlandi == 1 ? "Evet" : "Hayır" %></td>
                    <td><%= haber.EklenmeTarihi %></td>
                    <td><%= haber.Kaynak %></td>
                    <td><%= haber.Ad + " " + haber.Soyad %></td>
                    <td>
                        <div style="width: 100px;">
                            <button type="button" onclick="haberler.duzenle(this);">Düzenle</button>
                            <button type="button" onclick="haberler.sil(this);">Sil</button>
                        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } %>
</body>
</html>
