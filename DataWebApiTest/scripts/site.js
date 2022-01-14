var nospamcount = 0;
var kullanici = {
    giris: function () {
        $("form#formLogin button").attr("disabled", "disabled");
        if (localStorage.getItem("loginspam") === "1") {
            nospamcount = 99;
        }
        if (nospamcount > 3) {
            //basic spam check
            $.MessageBox("<h3 style='text-align:center; color:red;'>YASAK!</h3><b>Çok fazla yanlış giriş yaptınız lütfen daha sonra tekrar deneyiniz!</b>");
            $("#formLogin input, #formLogin button").attr("disabled", "disabled");
            kullanici.giris = null;
            localStorage.setItem("loginspam", "1");
        } else {
            var ajaxRequest = $.ajax({
                type: "POST",
                url: "/api/kullanici/giris",
                contentType: "application/json",
                async: true,
                data: JSON.stringify($("form#formLogin").serializeObject())
            });
            ajaxRequest.done(function (responseData, textStatus) {
                if (responseData.message === "OK") {
                    $(".loginsuccess").show(300);
                    setTimeout(function () {
                        location.href = "Dashboard.aspx";
                    }, 1500);
                } else {
                    $.MessageBox("Sistemde böyle bir kullanıcı yok lütfen girdiğiniz bilgileri kontrol ediniz!");
                    nospamcount++;
                }
            });
        }
        $("form#formLogin button").removeAttr("disabled");
    },
    cikisyap: function () {
        var ajaxRequest = $.ajax({
            type: "POST",
            url: "/api/kullanici/cikis",
            contentType: "application/json",
            async: true,
            data: {}
        });
        ajaxRequest.done(function (responseData, textStatus) {
            if (responseData.message === "OK") {
                location.href = "Login.aspx";
            } else {
                $.MessageBox("Bir sorun nedeniyle çıkış yapılamadı!");
            }
        });
    }
}
var $HABERLER_URL = "Admin/Haberler.aspx";
var dashboard = {
    init: function () {
        dashboard.sayfaYukle(".main", $HABERLER_URL);
        var wallpaper = (Math.floor(Math.random() * (5 - 1 + 1)) + 1) + ".jpg"
        $(".wallpaper").css("background-image", "url('css/wallpapers/" + wallpaper + "')")
        $(".main").fadeIn("slow", function () {
            $(this).show();
        });
    },
    geri: function () {
        dashboard.sayfaYukle(".main", $HABERLER_URL);
        $(".islemler").fadeOut("slow", function () {
            $(this).hide().empty();
            $(".main").fadeIn("slow", function () {
                $(this).show();
            });
        });
    },
    sayfaYukle: function (hedef, adres) {
        $("#loading").show();
        var ajaxRequest = $.ajax({
            type: "GET",
            url: adres,
            contentType: "text/html",
            async: true,
            data: {}
        });
        ajaxRequest.done(function (responseData, textStatus) {
            $(hedef).html(responseData);
            $("#loading").hide();
        });
    }
}
var haberler = {
    tumunusec: function (checkbox) {
        if (checkbox.checked) {
            $(".haberchkbox").prop("checked", true).addClass("secili");
        } else {
            $(".haberchkbox").prop("checked", false).removeClass("secili");
        }
    },
    habersec: function (checkbox) {
        if (checkbox.checked) {
            $(checkbox).addClass("secili");
        } else {
            $(checkbox).removeClass("secili");
        }
    },
    yeni: function () {
        dashboard.sayfaYukle(".islemler", "Admin/DuzenleYeni.aspx?id=0");
        $(".main").fadeOut("slow", function () {
            $(this).hide().empty();
            $(".islemler").fadeIn("slow", function () {
                $(this).show();
            });
        });
    },
    duzenle: function (btn) {
        var id = $(btn).parent().parent().parent().data("id");
        dashboard.sayfaYukle(".islemler", "Admin/DuzenleYeni.aspx?id=" + id);
        $(".main").fadeOut("slow", function () {
            $(this).hide().empty();
            $(".islemler").fadeIn("slow", function () {
                $(this).show();
            });
        });
    },
    kaydet: function () {
        var $dynamicUrl = "";
        if ($("input#ID").val() === "0") {
            $dynamicUrl = "api/haberler/haber/ekle";
        } else {
            $dynamicUrl = "api/haberler/haber/kaydet";
        }
        var ajaxRequest = $.ajax({
            type: "POST",
            url: $dynamicUrl,
            contentType: "application/json",
            async: true,
            data: JSON.stringify($("form#formHaber").serializeObject())
        });
        ajaxRequest.done(function (responseData, textStatus) {
            if (responseData.message === "OK" || responseData.HaberID !== 0) {
                dashboard.geri();
                $.MessageBox("İşlem tamamlanmıştır!");
            } else {
                $.MessageBox("Bir hata nedeniyle işlem yapılamadı!");
            }
        });
    },
    sil: function (btn) {
        var id = $(btn).parent().parent().parent().data("id");
        $.MessageBox({
            buttonDone: "Evet",
            buttonFail: "Hayır",
            message: "Bu haberi silmek istediğinizden emin misiniz?"
        }).done(function () {
            var ajaxRequest = $.ajax({
                type: "POST",
                url: "/api/haberler/haber/sil",
                contentType: "application/json",
                async: true,
                data: JSON.stringify({
                    "HaberID": id
                })
            });
            ajaxRequest.done(function (responseData, textStatus) {
                if (responseData.message === "OK") {
                    $(btn).parent().parent().parent().remove();
                    $.MessageBox("Haber silindi!");
                } else {
                    $.MessageBox("Bir sorun nedeniyle haber silinemedi!");
                }
            });

        }).fail(function () {
        });
    },
    secilenlerisil: function () {
        var silinen = 0;
        var secilisatir = $("#tblHaberler tbody tr input.secili").size();
        var silinecekHaberHTML = "<div style='overflow-y: auto; background-color:#f3f2f2; border: 1px dotted #ccc; height:150px;'><ul>";
        for (var i = 0; i < secilisatir; i++) {
            var haberbaslik = $.trim($("input.secili").eq(i).parent().next().text());
            silinecekHaberHTML += "<li>" + haberbaslik + "</li>";
        }
        silinecekHaberHTML += "</ul></div>";
        $.MessageBox({
            buttonDone: "Evet",
            buttonFail: "Hayır",
            message: secilisatir + " adet haberi silmek istediğinizden emin misiniz?" + silinecekHaberHTML
        }).done(function () {
            for (var i = 0; i < secilisatir; i++) {
                var HaberID = $("input.secili").eq(i).parent().parent().data("id");
                var ajaxRequest = $.ajax({
                    type: "POST",
                    url: "/api/haberler/haber/sil",
                    contentType: "application/json",
                    async: true,
                    data: JSON.stringify({
                        "HaberID": HaberID
                    })
                });
                ajaxRequest.done(function (responseData, textStatus) {
                    if (responseData.message !== "OK") {
                        $.MessageBox("Bir sorun nedeniyle haber silinemedi!");
                    }
                });
            }
            $("#loading").show();
            setTimeout(function () {
                dashboard.sayfaYukle(".main", $HABERLER_URL);
            }, 1000);
            $.MessageBox("Seçili haberler silindi!");
        }).fail(function () {
        });
    }
}