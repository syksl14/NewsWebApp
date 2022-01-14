<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DuzenleYeni.aspx.cs" Inherits="DataWebApiTest.Admin.DuzenleYeni" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="formHaber" action="javascript:haberler.kaydet();" align="center">
        <sy:HTMLControl ID="htmlControlHaber" runat="server" Class="" DataSource="DataWebApiTest.Models.Haberler">
            <Content>
                <table border="0" style="width: 100%;">
                    <tbody>
                        <tr>
                            <td class="sag">Başlık:
                            </td>
                            <td>
                                <input id="txtBaslik" name="Baslik" data-name="Baslik" type="text" required />
                            </td>
                        </tr>
                        <tr>
                            <td class="sag">Özet:
                            </td>
                            <td>
                                <textarea id="txtOzet" data-name="Ozet" name="Ozet" cols="20" rows="15" required></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="sag">Haber URL:
                            </td>
                            <td>
                                <input id="txtHaberURL" name="URL" data-name="URL" type="text" required />
                            </td>
                        </tr>
                        <tr>
                            <td class="sag">Resim URL:
                            </td>
                            <td>
                                <input id="txtResim" name="Resim" data-name="Resim" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td class="sag">Kaynak:
                            </td>
                            <td>
                                <sy:SelectControl ID="selectKaynaklar" name="KaynakID" runat="server" Class="" DisplayValue="Kaynak" data-name="KaynakID" SQL="SELECT KaynakID, Kaynak FROM Kaynaklar" Value="KaynakID" />
                            </td>
                        </tr>
                        <tr>
                            <td class="sag">Yayınlandı:
                            </td>
                            <td>
                                <input id="rY1" name="Yayinlandi" data-name="Yayinlandi" type="radio" value="True" />
                                <label for="rY1">Evet</label>
                                <input id="rY2" name="Yayinlandi" data-name="Yayinlandi" type="radio" value="False" />
                                <label for="rY2">Hayır</label>
                            </td>
                        </tr>
                          <tr>
                            <td>
                               
                            </td>
                            <td>
                                 <input id="ID" name="HaberID" data-name="HaberID" type="hidden" required value="0"/>
                                 <button type="button" onclick="dashboard.geri();">İptal</button>
                                <button type="submit">Kaydet</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </Content>
        </sy:HTMLControl>
    </form>
</body>
</html>
