<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DataWebApiTest.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>News Login</title>
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
    <div class="centerDiv">
        <form id="formLogin" action="javascript:kullanici.giris();">
            <h2>Kullanıcı Girişi</h2>
            <p class="loginsuccess">Giriş yapıldı! Yönlendirilyorsunuz...</p>
            <table border="0" align="center">
                <tbody>
                    <tr>
                        <td style="width: 150px; text-align:right;">E-Posta Adresi:
                        </td>
                        <td>
                            <input name="email" type="email" />
                        </td>
                    </tr>
                     <tr>
                        <td style="width: 150px; text-align:right;">Şifre:
                        </td>
                        <td>
                            <input name="sifre" type="password" />
                        </td>
                    </tr>
                      <tr>
                        <td style="width: 150px;">
                        </td>
                        <td  style="text-align:right;">
                           <button type="submit">Giriş Yap</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>
</body>
</html>
