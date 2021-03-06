USE [technetlogDb]
GO
/****** Object:  Table [technet].[ApiTokens]    Script Date: 15.01.2022 00:06:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [technet].[ApiTokens](
	[TokenID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ApiTokens_TokenID]  DEFAULT (newid()),
	[KullaniciGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ApiTokens] PRIMARY KEY CLUSTERED 
(
	[TokenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [technet].[Haberler]    Script Date: 15.01.2022 00:06:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [technet].[Haberler](
	[HaberID] [int] IDENTITY(1,1) NOT NULL,
	[Baslik] [nvarchar](100) NOT NULL,
	[Ozet] [nvarchar](350) NOT NULL,
	[Resim] [nvarchar](2500) NULL,
	[URL] [nvarchar](2500) NOT NULL,
	[EklenmeTarihi] [datetime] NOT NULL,
	[KaynakID] [int] NOT NULL,
	[Okunma] [bigint] NOT NULL CONSTRAINT [DF_Haberler_Okunma]  DEFAULT ((0)),
	[Yayinlandi] [bit] NOT NULL,
	[EkleyenGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Haberler] PRIMARY KEY CLUSTERED 
(
	[HaberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [technet].[Kaynaklar]    Script Date: 15.01.2022 00:06:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [technet].[Kaynaklar](
	[KaynakID] [int] IDENTITY(1,1) NOT NULL,
	[Kaynak] [nvarchar](50) NOT NULL,
	[WebSite] [nvarchar](500) NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Kaynaklar] PRIMARY KEY CLUSTERED 
(
	[KaynakID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [technet].[Kullanicilar]    Script Date: 15.01.2022 00:06:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [technet].[Kullanicilar](
	[KullaniciGuid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Kullanicilar_KullaniciGuid]  DEFAULT (newid()),
	[Ad] [nvarchar](50) NOT NULL,
	[Soyad] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Sifre] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Kullanicilar] PRIMARY KEY CLUSTERED 
(
	[KullaniciGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [technet].[HABERLER_V]    Script Date: 15.01.2022 00:06:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [technet].[HABERLER_V]
AS
SELECT        technet.Kaynaklar.KaynakID, technet.Haberler.HaberID, CONVERT(nvarchar(50), technet.Kullanicilar.KullaniciGuid) AS KullaniciGuid, technet.Kullanicilar.Ad, technet.Kullanicilar.Soyad, technet.Haberler.Baslik, 
                         technet.Haberler.Ozet, technet.Haberler.Resim, technet.Haberler.Okunma, technet.Haberler.URL, FORMAT(technet.Haberler.EklenmeTarihi, 'dd.MM.yyyy HH:mm') AS EklenmeTarihi, technet.Haberler.Yayinlandi, 
                         technet.Kaynaklar.Kaynak
FROM            technet.Kaynaklar INNER JOIN
                         technet.Haberler ON technet.Kaynaklar.KaynakID = technet.Haberler.KaynakID INNER JOIN
                         technet.Kullanicilar ON technet.Haberler.EkleyenGuid = technet.Kullanicilar.KullaniciGuid

GO
/****** Object:  View [technet].[KULLANICILAR_V]    Script Date: 15.01.2022 00:06:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [technet].[KULLANICILAR_V]
AS
SELECT        CONVERT(nvarchar(50), technet.Kullanicilar.KullaniciGuid) AS KullaniciGuid, CONVERT(nvarchar(50), technet.ApiTokens.TokenID) AS TokenID, technet.Kullanicilar.Ad, technet.Kullanicilar.Soyad, technet.Kullanicilar.Email, 
                         technet.Kullanicilar.Sifre
FROM            technet.ApiTokens INNER JOIN
                         technet.Kullanicilar ON technet.ApiTokens.KullaniciGuid = technet.Kullanicilar.KullaniciGuid

GO
INSERT [technet].[ApiTokens] ([TokenID], [KullaniciGuid]) VALUES (N'44e86333-0478-4b38-a603-83d696f37b32', N'5715f070-a801-4f01-8d0e-b29954d1ab10')
SET IDENTITY_INSERT [technet].[Haberler] ON 

INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (1, N'Veri Depolama Problemini Çözecek Yeni Bir Sistem Geliştirildi', N'Bilim insanlarının bulduğu yeni sistemin, veri depolama konusunda yaşanan sorunları kökünden çözmesi bekleniyor.', N'http://cdn.webtekno.com/media/cache/content_detail_v2/article/34538/manyetiklestirilmis-parcaciklar-veri-depolama-problemlerini-cozecek-1507128410.jpg', N'http://www.webtekno.com/veri-depolama-problemini-cozecek-yeni-bir-sistem-gelistirildi-h34538.html', CAST(N'2017-10-04 00:00:00.000' AS DateTime), 1, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (2, N'Instagram''dan Çaldığı Bebek Fotoğraflarıyla Kullanıcıları Dolandıran Kadın Yakalandı', N'Birleşik Krallık''ta bir kadın, Instagram''dan çaldığı bebek fotoğraflarını sahte profillerde paylaşıp bebeğin hasta olduğunu söyleyerek kullanıcıları dolandırdı. Kadın IP adresi sayesinde yakalandı.', N'http://www.webtekno.com/images/editor/default/0001/29/b828004f47e9f8eb9f79b31ef1125dd8f8706253.jpeg', N'http://www.webtekno.com/instagram-dan-caldigi-bebek-fotograflariyla-kullanicilari-dolandiran-kadin-yakalandi-h34537.html', CAST(N'2017-10-04 00:00:00.000' AS DateTime), 1, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (3, N'Neden Her Yıl Bu Kadar Fazla Akıllı Telefon Tanıtılıyor?', N'Her gün yeni bir akıllı telefonla tanışıyoruz. Apple bile bu yıl farklı iPhone tanıtırken, Samsung tam 23 farklı model ile tüm kullanıcılara hitap etmek için uğraştı.', N'http://www.webtekno.com/images/editor/default/0001/29/693714b04682bfe276a8e1879aa780dfb0f7f3d0.jpeg', N'http://www.webtekno.com/neden-her-yil-bu-kadar-fazla-akilli-telefon-tanitiliyor-h34531.html', CAST(N'2017-10-04 00:00:00.000' AS DateTime), 1, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (4, N'Google Geliştiriciler İçin Yeni Belge Veritabanını Duyurdu', N'Uygulama geliştiricilerine desteğini esirgemeyen Google, bugün uygulama geliştirme platformu olan Firebase için yeni bir veritabanı hizmeti başlattı.', N'http://cdn.webtekno.com/media/cache/content_detail_v2/article/34491/google-gelistiriciler-icin-yeni-belge-veritabanini-duyurdu-1507059382.jpg', N'http://www.webtekno.com/google-gelistiriciler-icin-yeni-belge-veritabanini-duyurdu-h34491.html', CAST(N'2017-10-04 00:00:00.000' AS DateTime), 1, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (5, N'PUBG''ye Alternatif Olarak Oynayabileceğiniz 6 Ücretsiz Oyun!', N'Son günlerin en popüler oyunlarından birisi olan PUBG''ye alternatif olacak 6 ücretsiz oyun listeledik. Battle Royale tarzına hitap eden bu oyunlara şans vermenizi öneriyoruz.', N'http://www.webtekno.com/images/editor/default/0001/29/19b454ff83517bafc31b13ce779a51c34eeda409.jpeg', N'http://www.webtekno.com/pubg-ye-alternatif-olarak-oynayabileceginiz-6-ucretsiz-oyun-h34528.html', CAST(N'2017-10-04 00:00:00.000' AS DateTime), 1, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (12, N'3D beyin taraması yapıldı!', N'Beyinde bir sorun oluştuğunda, her milimetrede bir tümör veya tıkalı arter gibi değişkenler incelenir. Yeni geliştirilen 3D beyin taraması yöntemi, teşhis ve tedaviyi kolaylaştırıyor. Böylelikle büyüme veya hasarın bir kopyasını 3D basılabiliyor ve hastalık durumu incelenebiliyor.', N'https://ceres.shiftdelete.net/580x330/original/2017/10/3D-beyin-taramas%C4%B1-y%C3%B6ntemi-shiftdelete.jpg', N'https://shiftdelete.net/3d-beyin-taramasi-yapildi', CAST(N'2017-10-05 00:00:00.000' AS DateTime), 2, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (14, N'Google Home Max duyuruldu!', N'Google Home Max yapay zeka destekli ev teknolojileri kapsamında Google tarafından tanıtıldı. Ses yüksekliği tarafında Google Home’dan tam 20 kat üstün olan bu ilginç hoparlör, barındırdığı donanım ve yetenekler ile dikkat çekiyor.', N'https://ceres.shiftdelete.net/580x330/original/2017/10/madebygoogle_2017-oct-04.jpg', N'https://shiftdelete.net/google-home-max-duyuruldu', CAST(N'2017-10-05 00:00:00.000' AS DateTime), 2, 10, 1, N'38958eab-eb18-4cdb-ac9f-33cba2b1b0a7')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (35, N'HP Windows Phone telefon üretimini durdurdu!', N'Android ve iOS karşısında her geçen gün daha çok kan kaybeden Windows Phone, HP’nin yaptığı açıklamayla sona yaklaşıyor. Yapılan açıklamayla HP Windows Phone telefon üretimini şu an için rafa kaldırdıklarını belirtti.', N'https://ceres.shiftdelete.net/580x330/original/2017/10/hp-windows-phone.png', N'https://shiftdelete.net/hp-windows-telefon-uretimini-durdurdu', CAST(N'2017-10-08 01:28:35.773' AS DateTime), 2, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (36, N'Uber, ekranınızı kaydediyor!', N'Başı bir türlü dertten kurtulamayan Uber, bu sefer de iPhone kullanıcılarından tepki çekecek gibi gözüküyor. Geçtiğimiz günlerde ortaya çıkan bilgilere göre Uber iPhone kullanıcılarının ekranını kaydediyor.', N'https://ceres.shiftdelete.net/580x330/original/2017/10/Uber-iPhone-kullan%C4%B1c%C4%B1lar%C4%B1n%C4%B1n-ekran%C4%B1n%C4%B1-kaydediyor.png', N'https://shiftdelete.net/uber-iphone-kullanicilarinin-ekranini-kaydediyor', CAST(N'2017-10-08 01:47:26.520' AS DateTime), 2, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (37, N'Kaspersky, NSA’den veri çalmış!', N'ABD ile güvenlik devi Kaspersky‘ın arası yaklaşık 3 aydır bozuk. Kullanıcılara Kaskersky kullanmamalarını öğütleyecek kadar ileriye giden ABD‘ye göre Kaspersky, NSA’den veri çalmış!', N'https://ceres.shiftdelete.net/580x330/original/2017/10/kaspersky-NSAden-veri-%C3%A7alm%C4%B1%C5%9F.jpg', N'https://shiftdelete.net/kaspersky-nsa-den-veri-calmis', CAST(N'2017-10-08 01:48:24.490' AS DateTime), 2, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (38, N'AOL Messenger Veda Ediyor!', N'İnternet’in yeni yaygınlaştığı yıllarda ortaya çıkan popüler mesajlaşma uygulamalarından birisi olan AOL Messenger, teknolojinin hızlı akışına ayak uyduramayarak veda ediyor. ', N'https://ceres.shiftdelete.net/580x330/original/2017/10/aol_messenger.jpg', N'https://shiftdelete.net/aol-messenger-veda-ediyor', CAST(N'2017-10-08 01:48:41.213' AS DateTime), 2, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (39, N'Tesla’nın otonom tırı ne zaman tanıtılacak?', N'Otomobil sektöründe bir devrim yapan Tesla, elektrikli otomobilleriyle tüm dünyada adından bahsettirdi. Peki Elon Musk’ın sıradaki hedefi olan Tesla otonom tır ne zaman tanıtılacak?', N'https://ceres.shiftdelete.net/580x330/original/2017/10/tesla-otonom-t%C4%B1r.jpg', N'https://shiftdelete.net/tesla-otonom-tir-ne-zaman-tanitilacak', CAST(N'2017-10-08 01:48:54.490' AS DateTime), 2, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (40, N'İkinci Dünya Savaşı''nın En Büyük Gizemlerinden Biri Yapay Zeka ile Çözülebilir!', N'Veri işleme ve birbiriyle alakalı noktalarını yapboz gibi birleştirmede usta olan yapay zeka algoritmaları, İkinci Dünya Savaşı''nın gizemlerinden birini aydınlatmak için kullanılacak.', N'http://www.webtekno.com/images/editor/default/0001/29/8052e9316204a0fc078d40f9b00d63c562800a5d.jpeg', N'http://www.webtekno.com/ikinci-dunya-savasi-nin-en-buyuk-gizemlerinden-biri-yapay-zeka-ile-cozulebilir-h34688.html', CAST(N'2017-10-08 04:02:45.953' AS DateTime), 1, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (41, N'Çok Oyunculu EVE Online, Mobil Platforma Taşınıyor', N'Keşfedilmeyi bekleyen devasa evrende savaşlarınızı, telefonunuzun küçük ekranında, online olarak çok sayıda oyuncuyla birlikte oynayabileceksiniz.', N'http://cdn.webtekno.com/media/cache/showcase_small_v2/article/34685/cok-oyunculu-eve-online-mobil-platforma-tasiniyor-1507399185.png', N'http://www.webtekno.com/cok-oyunculu-eve-online-mobil-platforma-tasiniyor-h34685.html', CAST(N'2017-10-08 04:05:38.743' AS DateTime), 1, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (42, N'Xposed Framework Sonunda Android 7.0 ve 7.1''i Destekliyor!', N'Android ekosisteminin Lollipop ve KitKat zamanlarında inanılmaz derecede popüler olan sistem düzeyi kişiselleştirmelere imkan sağlayan yazılımı Xposed Framework, sonunda Nougat desteğine sahip oldu.', N'http://www.webtekno.com/images/editor/default/0001/29/c7e6909f15b34c342a25619ef93235ec62b561bf.jpeg', N'http://www.webtekno.com/xposed-framework-sonunda-android-7-0-ve-7-1-i-destekliyor-h34713.html', CAST(N'2017-10-09 00:54:51.350' AS DateTime), 1, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (43, N'5 Bin Sterline Öldükten Sonra Yeniden Hayata Döndürmeyi Vadediyorlar!', N'İngiltereli bilim insanları yapmış olduğu çalışma ile birlikte, insanları öldükten sonra yeniden hayata döndürmeyi vadediyorlar.', N'http://www.webtekno.com/images/editor/default/0001/29/a9a272818e5597e4a6626d6a1abe0f9014d8f6f6.jpeg', N'http://www.webtekno.com/5-bin-sterline-oldukten-sonra-yeniden-hayatta-dondurmeyi-vaat-ediyorlar-h34705.html', CAST(N'2017-10-09 00:55:39.853' AS DateTime), 1, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (44, N'Apple, güncellemelerle eski cihazları yavaşlatıyor mu?', N'Apple’ın her yeni iOS güncellemesi ile eski iPhone modellerini yavaşlattığı iddiası çürütüldü. Futuremerk’in yaptığı analizler iddiaların doğru olmadığını gösteriyor.', N'https://ceres.shiftdelete.net/500x300/original/2017/10/iOS-g%C3%BCncellemesi-iPhoneu-yava%C5%9Flat%C4%B1yor-mu.jpg', N'https://shiftdelete.net/apple-ios-guncellemeleriyle-eski-cihazlari-yavaslatiyor-mu', CAST(N'2017-10-09 00:56:44.467' AS DateTime), 2, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (49, N'Can Sıkıntınızı Bertaraf Edip Sizi Kahkahalara Boğacak Aşırı Eğlenceli 35 Tweet', N'Birazdan göreceğiniz birbirinden komik tweet''ler sayesinde ne can sıkıntısı kalacak ne de dert tasa. Hafta içi stresini atmak için birebir olan bu viral tweet''leri okurken kahkaha atmaktan karnınıza ağrılar girebilir...', N'https://cdn.webtekno.com/media/cache/showcase_small_v2/article/119630/eglenceli-komik-tweetler-1642184629.jpg', N'https://www.webtekno.com/eglenceli-komik-tweetler-h119630.html', CAST(N'2022-01-14 23:20:01.330' AS DateTime), 1, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (50, N'Çentiksiz, Delikli Ekranla Gelmesi Beklenen iPhone 14''ün Nasıl Görüneceği Ortaya Çıktı', N'Phone 14 ailesinin delikli ekranlı bir tasarıma sahip olacağı iddialarıyla ilgili dikkat çeken bir gelişme yaşandı. Hazırlanan özel bir duvar kağıdı, bu telefonlarda yer alacak delikli ekran tasarımının nasıl görünebileceğini ortaya koydu.', N'https://cdn.webtekno.com/media/cache/showcase_small_v2/article/119486/iphone-14-delikli-ekran-tasarimi-boyle-gorunebilir-1641819432.jpg', N'https://www.webtekno.com/iphone-14-nasil-gorunecegi-ortaya-cikti-h119486.html', CAST(N'2022-01-14 23:35:41.987' AS DateTime), 1, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (53, N'8. Nesil iPad ve Yepyeni iPad Air, Türkiye''de Satışa Sunuldu (Cüzdanlarınızı Saklayın)', N'Apple, en yeni iPad ve iPad Air modellerini Türkiye''de satışa sundu. Özellikle yeni iPad Air, fiyatıyla meraklılarını bir miktar üzebilir.
Apple, geçtiğimiz ay gerçekleştirmiş olduğu lansman etkinliğinde duyurduğu 10,2 inç ekranlı yeni iPad ile 10,9 inç ekranlı yeni iPad Air’ı Türkiye’de satışa sundu. ', N'https://cdn.webtekno.com/media/cache/showcase_small_v2/article/101290/8-nesil-ipad-2020-ipad-air-turkiye-fiyati-1603808820.jpg', N'https://www.webtekno.com/8-nesil-ipad-2020-ipad-air-turkiye-fiyati-h101290.html', CAST(N'2022-01-14 23:39:29.940' AS DateTime), 1, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (54, N'Samsung Galaxy Tab S8 serisinin tüm özellikleri sızdırıldı!', N'Samsung, ürettiği akıllı telefonlarıyla Android tarafının güçlü oyuncuları arasında bulunuyor. Bunun yanında şirket, tablet sektöründe liderliği elde tutan Apple ile savaşmak istiyor ve onun başarısına ulaşabilmek için çalışıyor.', N'https://i2.wp.com/shiftdelete.net/wp-content/uploads/2022/01/samsung-galaxy-tab-s8-serisinin-tum-ozellikleri-sizdirildi.jpg?w=1280&ssl=1', N'https://shiftdelete.net/samsung-galaxy-tab-s8-serisinin-tum-ozellikleri-sizdirildi', CAST(N'2022-01-14 23:40:36.630' AS DateTime), 2, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
INSERT [technet].[Haberler] ([HaberID], [Baslik], [Ozet], [Resim], [URL], [EklenmeTarihi], [KaynakID], [Okunma], [Yayinlandi], [EkleyenGuid]) VALUES (55, N'MIUI 13 kanlı canlı karşımızda!', N'SDN ofisinde kutusundan çıkan Xiaomi 12 Pro''da yer alan yeni MIUI 13 arayüzünü sizler için inceledik. İşte yenilikler!

Geçen ay tanıtılan Xiaomi 12 Pro, SDN ofisinde kutusundan çıktı. Ardından Xiaomi’nin en yeni arayüzü MIUI 13 incelemesi ile karşınızdayız.', N'https://i1.wp.com/shiftdelete.net/wp-content/uploads/2022/01/miui-13-inceleme.jpeg?w=1600&ssl=1', N'https://shiftdelete.net/miui-13-kanli-canli-karsimizda', CAST(N'2022-01-14 23:42:27.780' AS DateTime), 2, 0, 1, N'5715f070-a801-4f01-8d0e-b29954d1ab10')
SET IDENTITY_INSERT [technet].[Haberler] OFF
SET IDENTITY_INSERT [technet].[Kaynaklar] ON 

INSERT [technet].[Kaynaklar] ([KaynakID], [Kaynak], [WebSite], [Email]) VALUES (1, N'Webtekno', N'http://www.webtekno.com', N'info@webtekno.com')
INSERT [technet].[Kaynaklar] ([KaynakID], [Kaynak], [WebSite], [Email]) VALUES (2, N'ShiftDelete', N'http://www.shiftdelete.net', N'info@shiftdelete.net')
SET IDENTITY_INSERT [technet].[Kaynaklar] OFF
INSERT [technet].[Kullanicilar] ([KullaniciGuid], [Ad], [Soyad], [Email], [Sifre]) VALUES (N'38958eab-eb18-4cdb-ac9f-33cba2b1b0a7', N'Example', N'User', N'user@example.com', N'123')
INSERT [technet].[Kullanicilar] ([KullaniciGuid], [Ad], [Soyad], [Email], [Sifre]) VALUES (N'5715f070-a801-4f01-8d0e-b29954d1ab10', N'Selahattin', N'Yüksel', N'iletisim@selahattinyuksel.net', N'123')
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Kaynaklar"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 219
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Kullanicilar"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 207
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Haberler"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 220
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 6420
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'technet', @level1type=N'VIEW',@level1name=N'HABERLER_V'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'technet', @level1type=N'VIEW',@level1name=N'HABERLER_V'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ApiTokens"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 157
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Kullanicilar"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 171
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4020
         Alias = 2760
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'technet', @level1type=N'VIEW',@level1name=N'KULLANICILAR_V'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'technet', @level1type=N'VIEW',@level1name=N'KULLANICILAR_V'
GO
