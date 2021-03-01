import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';
import 'package:uludag_social/models/kullanici.dart';
import 'package:uludag_social/pages/profiliDuzenle.dart';
import 'package:uludag_social/services/firestoreServisi.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';
import 'package:uludag_social/models/gonderiler.dart';
import 'package:uludag_social/widgets/gonderiKartlari.dart';

class Profil extends StatefulWidget {
  final String profilSahibiId;

  const Profil({Key key, this.profilSahibiId}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _evArkadasiGonderiSayisi = 0;
  int _notGonderiSayisi = 0;
  int _esyaGonderiSayisi = 0;
  int _yolculukGonderiSayisi = 0;

  int _takipci = 0;
  int _takipEdilen = 0;
  String _aktifKullaniciId;
  Kullanici _profilSahibi;
  List<EvArkadasiGonderi> _evArkadasiGonderiler = [];
  List<EsyaGonderi> _esyaGonderiler = [];
  List<YolculukGonderi> _yolculukGonderiler = [];
  List<NotGonderi> _notGonderiler = [];

  _takipciSayisiGetir() async {
    int takipciSayisi =
        await FirestoreServisi().takipciSayisi(widget.profilSahibiId);
    if (mounted) {
      setState(() {
        _takipci = takipciSayisi;
      });
    }
  }

  _takipEdilenSayisiGetir() async {
    int takipEdilenSayisi =
        await FirestoreServisi().takipEdilenSayisi(widget.profilSahibiId);
    if (mounted) {
      setState(() {
        _takipEdilen = takipEdilenSayisi;
      });
    }
  }

  _evArkadasiGonderileriGetir() async {
    List<EvArkadasiGonderi> evArkadasiGonderiler = await FirestoreServisi()
        .evArkadasiGonderileriGetir(widget.profilSahibiId);
    if (mounted) {
      setState(() {
        _evArkadasiGonderiler = evArkadasiGonderiler;
        _evArkadasiGonderiSayisi = _evArkadasiGonderiler.length;
      });
    }
  }

  _yolculukGonderileriGetir() async {
    List<YolculukGonderi> yolculukGonderiler = await FirestoreServisi()
        .yolculukGonderileriGetir(widget.profilSahibiId);
    if (mounted) {
      setState(() {
        _yolculukGonderiler = yolculukGonderiler;
        _yolculukGonderiSayisi = _yolculukGonderiler.length;
      });
    }
  }

  _notGonderileriGetir() async {
    List<NotGonderi> notGonderiler =
        await FirestoreServisi().notGonderileriGetir(widget.profilSahibiId);
    if (mounted) {
      setState(() {
        _notGonderiler = notGonderiler;
        _notGonderiSayisi = _notGonderiler.length;
      });
    }
  }

  _esyaGonderileriGetir() async {
    List<EsyaGonderi> esyaGonderiler =
        await FirestoreServisi().esyaGonderileriGetir(widget.profilSahibiId);
    if (mounted) {
      setState(() {
        _esyaGonderiler = esyaGonderiler;
        _esyaGonderiSayisi = _esyaGonderiler.length;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _takipciSayisiGetir();
    _takipEdilenSayisiGetir();
    _aktifKullaniciId =
        Provider.of<YetkilendirmeServisi>(context, listen: false)
            .aktifKullaniciId;
    _evArkadasiGonderileriGetir();
    _yolculukGonderileriGetir();
    _notGonderileriGetir();
    _esyaGonderileriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: widget.profilSahibiId == _aktifKullaniciId
            ? _drawer(context)
            : null,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MelihColors().koyuGri,
          title: Text(
            'Profil',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            widget.profilSahibiId == _aktifKullaniciId
                ? IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openEndDrawer();
                    })
                : null,
          ],
        ),
        body: FutureBuilder<Object>(
            future: FirestoreServisi().kullaniciGetir(widget.profilSahibiId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              _profilSahibi = snapshot.data;

              return ListView(
                children: [
                  _profilDetaylari(snapshot.data),
                ],
              );
            }),
        backgroundColor: MelihColors().acikGri,
      ),
    );
  }

  Widget _profilDetaylari(Kullanici profilData) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: _height * 0.013,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 15, right: 15),
            child: Row(
              children: [
                Container(
                  height: 55.0,
                  width: 55.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(profilData.fotoUrl)),
                      color: MelihColors().acikGri,
                      shape: BoxShape.circle),
                  child: profilData.fotoUrl.isEmpty
                      ? SvgPicture.network(
                          "https://avatars.dicebear.com/api/bottts/" +
                              profilData.kullaniciAdi +
                              ".svg?background=%232f3136",
                        )
                      : null, // Image.network(userImage),
                ),
                // CircleAvatar(
                //   backgroundImage: profilData.fotoUrl.isEmpty
                //       ? SvgPicture.network(
                //           "https://avatars.dicebear.com/api/bottts/" +
                //               profilData.kullaniciAdi +
                //               ".svg?background=%232f3136",
                //         )
                //       : NetworkImage(profilData.fotoUrl),
                //   backgroundColor: MelihColors().main,
                //   radius: 50,
                // ),

                // ClipRRect(
                //   borderRadius: BorderRadius.circular(20),
                //   child: FittedBox(
                //     child: Container(
                //       height: 100.0,
                //       width: 100.0,
                //       decoration: BoxDecoration(
                //           color: MelihColors().acikGri, shape: BoxShape.circle),
                //       child:
                //           profilData.fotoUrl == null || profilData.fotoUrl == ''
                //               ? SvgPicture.network(
                //                   "https://avatars.dicebear.com/api/bottts/" +
                //                       profilData.kullaniciAdi +
                //                       ".svg?background=%232f3136",
                //                 )
                //               : CachedNetworkImage(
                //                   imageUrl: profilData.fotoUrl,
                //                   placeholder: (context, url) =>
                //                       CircularProgressIndicator(),
                //                 ), // Image.network(userImage),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _sosyalSayac(baslik: "Takipçi", sayi: _takipci),
                      _sosyalSayac(baslik: "Takip", sayi: _takipEdilen),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: _height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Text(profilData.kullaniciAdi,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ),
          profilData.hakkinda == null
              ? SizedBox(
                  height: 0,
                )
              : SizedBox(
                  height: _height * 0.01,
                ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              profilData.hakkinda,
              style: TextStyle(
                fontSize: 15,
                color: MelihColors().white,
              ),
            ),
          ),
          // SizedBox(
          //   height: _height * 0.01,
          // ),
          widget.profilSahibiId == _aktifKullaniciId
              ? _profiliDuzenleButon()
              : Text('Buraya takip et butonu gelecek'),
          SizedBox(
            height: 50,
            child: TabBar(
              indicatorColor: MelihColors().main,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        FontAwesomeIcons.userFriends,
                        size: 20,
                      ),
                      Text('$_evArkadasiGonderiSayisi')
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        FontAwesomeIcons.shoppingCart,
                        size: 20,
                      ),
                      Text('$_esyaGonderiSayisi')
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        FontAwesomeIcons.car,
                        size: 20,
                      ),
                      Text('$_yolculukGonderiSayisi')
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        FontAwesomeIcons.book,
                        size: 20,
                      ),
                      Text('$_notGonderiSayisi')
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              children: [
                Column(
                  children: [
                    _evArkadasiGonderileriGoster(profilData),
                  ],
                ),
                Column(
                  children: [
                    _esyaGonderileriGoster(profilData),
                  ],
                ),
                Column(
                  children: [
                    _yolculukGonderileriGoster(profilData),
                  ],
                ),
                Column(
                  children: [
                    _notGonderileriGoster(profilData),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _evArkadasiGonderileriGoster(Kullanici profilData) {
    return Expanded(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: false,
          itemCount: _evArkadasiGonderiler.length,
          itemBuilder: (context, index) {
            return index != 0
                ? EvArkadasiGonderiKarti(
                    gonderi: _evArkadasiGonderiler[index],
                    yayinlayan: profilData,
                  )
                : SizedBox(
                    height: 0,
                  );
          }),
    );
  }

  Widget _yolculukGonderileriGoster(Kullanici profilData) {
    return Expanded(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: false,
          itemCount: _yolculukGonderiler.length,
          itemBuilder: (context, index) {
            return index != 0
                ? YolculukGonderiKarti(
                    gonderi: _yolculukGonderiler[index],
                    yayinlayan: profilData,
                  )
                : SizedBox(
                    height: 0,
                  );
          }),
    );
  }

  Widget _esyaGonderileriGoster(Kullanici profilData) {
    return Expanded(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: false,
          itemCount: _esyaGonderiler.length,
          itemBuilder: (context, index) {
            return index != 0
                ? EsyaGonderiKarti(
                    gonderi: _esyaGonderiler[index],
                    yayinlayan: profilData,
                  )
                : SizedBox(
                    height: 0,
                  );
          }),
    );
  }

  Widget _notGonderileriGoster(Kullanici profilData) {
    return Expanded(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: false,
          itemCount: _notGonderiler.length,
          itemBuilder: (context, index) {
            return index != 0
                ? NotGonderiKarti(
                    gonderi: _notGonderiler[index],
                    yayinlayan: profilData,
                  )
                : SizedBox(
                    height: 0,
                  );
          }),
    );
  }

  Widget _drawer(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Drawer(
        elevation: 50,
        child: Stack(
          children: [
            Container(
              color: MelihColors().koyuGri,
              height: _height,
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: _height * 0.2,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfiliDuzenle(
                                profil: _profilSahibi,
                              )));
                    },
                    child: Container(
                      height: _height * 0.08,
                      width: _width * 0.6,
                      decoration: BoxDecoration(
                          color: MelihColors().acikacikGri,
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: _width * 0.06,
                                  color: MelihColors().white,
                                ),
                                Text(
                                  '  Profili Düzenle',
                                  style: TextStyle(
                                      fontSize: _height / 45,
                                      color: MelihColors().white),
                                )
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              size: _width * 0.08,
                              color: MelihColors().white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.04,
                  ),
                  InkWell(
                    onTap: () => print("butona bastın"),
                    child: Container(
                      height: _height * 0.08,
                      width: _width * 0.6,
                      decoration: BoxDecoration(
                          color: MelihColors().acikacikGri,
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.lock,
                                  size: _width * 0.06,
                                  color: MelihColors().white,
                                ),
                                Text(
                                  ' Parolanı Değiştir',
                                  style: TextStyle(
                                      fontSize: _height / 45,
                                      color: MelihColors().white),
                                )
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              size: _width * 0.08,
                              color: MelihColors().white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.04,
                  ),
                  InkWell(
                    onTap: () => print("buton 1"),
                    child: Container(
                      height: _height * 0.08,
                      width: _width * 0.6,
                      decoration: BoxDecoration(
                          color: MelihColors().acikacikGri,
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.report,
                                  size: _width * 0.06,
                                  color: MelihColors().white,
                                ),
                                Text(
                                  '  Sorun bildir',
                                  style: TextStyle(
                                      fontSize: _height / 45,
                                      color: MelihColors().white),
                                )
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              size: _width * 0.08,
                              color: MelihColors().white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.04,
                  ),
                  InkWell(
                    onTap: () => print("buton 1"),
                    child: Container(
                      height: _height * 0.08,
                      width: _width * 0.6,
                      decoration: BoxDecoration(
                          color: MelihColors().acikacikGri,
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.favorite_outline,
                                  size: _width * 0.06,
                                  color: MelihColors().white,
                                ),
                                Text(
                                  '  Arkadaşını davet et',
                                  style: TextStyle(
                                      fontSize: _height / 45,
                                      color: MelihColors().white),
                                )
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              size: _width * 0.08,
                              color: MelihColors().white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.04,
                  ),
                  InkWell(
                    onTap: _cikisYap,
                    child: Container(
                      height: _height * 0.08,
                      width: _width * 0.6,
                      decoration: BoxDecoration(
                          color: MelihColors().red,
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.exit_to_app_sharp,
                                    size: _width * 0.06, color: Colors.white),
                                Text('  Çıkış Yap',
                                    style: TextStyle(
                                        fontSize: _height / 45,
                                        color: Colors.white))
                              ],
                            ),
                            // Icon(
                            //   Icons.keyboard_arrow_right,
                            //   size: _width * 0.08,
                            //   color: MelihColors().white,
                            // )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _profiliDuzenleButon() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfiliDuzenle(
                        profil: _profilSahibi,
                      )));
            },
            child: Text(
              'Profili Düzenle',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            )),
      ),
    );
  }

  Widget _sosyalSayac({String baslik, int sayi}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          sayi.toString(),
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          baslik,
          style: TextStyle(fontSize: 15, color: MelihColors().white),
        ),
      ],
    );
  }

  void _cikisYap() {
    Provider.of<YetkilendirmeServisi>(context, listen: false).cikisYap();
  }
}
