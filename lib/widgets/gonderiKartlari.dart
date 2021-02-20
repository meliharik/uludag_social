import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';
import 'package:uludag_social/models/gonderiler.dart';
import 'package:uludag_social/models/kullanici.dart';
import 'package:uludag_social/services/firestoreServisi.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';

class EvArkadasiGonderiKarti extends StatefulWidget {
  final EvArkadasiGonderi gonderi;
  final Kullanici yayinlayan;

  const EvArkadasiGonderiKarti({Key key, this.gonderi, this.yayinlayan})
      : super(key: key);
  @override
  _EvArkadasiGonderiKartiState createState() => _EvArkadasiGonderiKartiState();
}

class _EvArkadasiGonderiKartiState extends State<EvArkadasiGonderiKarti> {
  int _begeniSayisi = 0;
  bool _begendin = false;
  String _aktifKullaniciId;

  @override
  void initState() {
    super.initState();
    _aktifKullaniciId =
        Provider.of<YetkilendirmeServisi>(context, listen: false)
            .aktifKullaniciId;
    _begeniSayisi = widget.gonderi.begeniSayisi;
    evArkadasiBegeniVarMi();
  }

  evArkadasiBegeniVarMi() async {
    bool evArkadasiBegeniVarMi = await FirestoreServisi()
        .evArkadasiBegeniVarMi(widget.gonderi, _aktifKullaniciId);
    if (evArkadasiBegeniVarMi) {
      if (mounted) {
        setState(() {
          _begendin = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // Image.network(widget.gonderi.gonderiResmiUrl),
        // CircleAvatar(backgroundImage: NetworkImage(widget.yayinlayan.fotoUrl)),
        // Container(
        //   height: MediaQuery.of(context).size.height * 0.3,
        //   color: Colors.amber,
        //   child:
        //       Text('Benim Kullanıcı Adım: ${widget.yayinlayan.kullaniciAdi}'),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Container(
            decoration: BoxDecoration(
                color: MelihColors().acikacikGri,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: _width * 0.9,
            height: _height * 0.23,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: _height / 55,
                            backgroundImage:
                                NetworkImage(widget.yayinlayan.fotoUrl),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              widget.yayinlayan.kullaniciAdi,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: _height / 50),
                            ),
                          )
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Row(children: [
                        _aktifKullaniciId == widget.gonderi.yayinlayanId
                            ? IconButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  size: _height / 45,
                                  color: Colors.white,
                                ),
                                onPressed: () => _detaylarButonu())
                            : null
                      ]),
                    ],
                  ),
                ),
                Divider(
                  color: MelihColors().white.withOpacity(0.8),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.gonderi.baslik,
                        style: TextStyle(
                            color: MelihColors().white,
                            fontWeight: FontWeight.bold,
                            fontSize: _height / 55),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: _begeniDegistir,
                            icon: !_begendin
                                ? Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                    size: _height / 35,
                                  )
                                : Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: _height / 35,
                                  ),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: _height / 55),
                                  text: _begeniSayisi.toString()),
                              // TextSpan(
                              //     style: TextStyle(
                              //         color: Colors.white.withOpacity(0.8),
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: _height / 45),
                              //     text: ' beğeni'),
                            ]),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () => print(
                              "evArkadaşı gönderi detay sayfasına gidecek"),
                          child: RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                  child: Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Icon(
                                  FontAwesomeIcons.infoCircle,
                                  size: _height / 50,
                                  color: MelihColors().main,
                                ),
                              )),
                              TextSpan(
                                text: ' Detaylar',
                                style: TextStyle(
                                    color: MelihColors().main,
                                    fontWeight: FontWeight.bold,
                                    fontSize: _height / 55),
                              )
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _begeniDegistir() {
    if (_begendin) {
      setState(() {
        _begendin = false;
        _begeniSayisi = _begeniSayisi - 1;
      });
      FirestoreServisi()
          .evArkadasiGonderiBegeniKaldir(widget.gonderi, _aktifKullaniciId);
    } else {
      setState(() {
        _begendin = true;
        _begeniSayisi = _begeniSayisi + 1;
      });
      FirestoreServisi()
          .evArkadasiGonderiBegen(widget.gonderi, _aktifKullaniciId);
    }
  }

  void _detaylarButonu() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xff141414),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  color: MelihColors().acikGri,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Sil'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Sil'),
                    onTap: null,
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Sil'),
                    onTap: null,
                  )
                ],
              ),
            ),
          );
        });
  }
}

class YolculukGonderiKarti extends StatefulWidget {
  final YolculukGonderi gonderi;
  final Kullanici yayinlayan;

  const YolculukGonderiKarti({Key key, this.gonderi, this.yayinlayan})
      : super(key: key);
  @override
  _YolculukGonderiKartiState createState() => _YolculukGonderiKartiState();
}

class _YolculukGonderiKartiState extends State<YolculukGonderiKarti> {
  int _begeniSayisi = 0;
  bool _begendin = false;
  String _aktifKullaniciId;

  @override
  void initState() {
    super.initState();
    _aktifKullaniciId =
        Provider.of<YetkilendirmeServisi>(context, listen: false)
            .aktifKullaniciId;
    _begeniSayisi = widget.gonderi.begeniSayisi;
    yolculukBegeniVarMi();
  }

  yolculukBegeniVarMi() async {
    bool yolculukBegeniVarMi = await FirestoreServisi()
        .yolculukBegeniVarMi(widget.gonderi, _aktifKullaniciId);
    if (yolculukBegeniVarMi) {
      if (mounted) {
        setState(() {
          _begendin = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Container(
            decoration: BoxDecoration(
                color: MelihColors().acikacikGri,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: _width * 0.9,
            height: _height * 0.23,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: _height / 55,
                            backgroundImage:
                                NetworkImage(widget.yayinlayan.fotoUrl),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              widget.yayinlayan.kullaniciAdi,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: _height / 50),
                            ),
                          )
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Row(children: [
                        _aktifKullaniciId == widget.gonderi.yayinlayanId
                            ? IconButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  size: _height / 45,
                                  color: Colors.white,
                                ),
                                onPressed: () => _detaylarButonu())
                            : null
                      ]),
                    ],
                  ),
                ),
                Divider(
                  color: MelihColors().white.withOpacity(0.8),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.gonderi.baslik,
                        style: TextStyle(
                            color: MelihColors().white,
                            fontWeight: FontWeight.bold,
                            fontSize: _height / 55),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(0),
                            child: IconButton(
                              onPressed: _begeniDegistir,
                              icon: !_begendin
                                  ? Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: _height / 35,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: _height / 35,
                                    ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: _height / 55),
                                  text: _begeniSayisi.toString()),
                              // TextSpan(
                              //     style: TextStyle(
                              //         color: Colors.white.withOpacity(0.8),
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: _height / 45),
                              //     text: ' beğeni'),
                            ]),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: InkWell(
                          onTap: () =>
                              print("Yolculuk gönderi detay sayfasına gidecek"),
                          child: RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                  child: Icon(
                                FontAwesomeIcons.infoCircle,
                                size: _height / 50,
                                color: MelihColors().red,
                              )),
                              TextSpan(
                                text: '  Detaylar',
                                style: TextStyle(
                                    color: MelihColors().red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: _height / 55),
                              )
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _begeniDegistir() {
    if (_begendin) {
      setState(() {
        _begendin = false;
        _begeniSayisi = _begeniSayisi - 1;
      });
      FirestoreServisi()
          .yolculukGonderiBegeniKaldir(widget.gonderi, _aktifKullaniciId);
    } else {
      setState(() {
        _begendin = true;
        _begeniSayisi = _begeniSayisi + 1;
      });
      FirestoreServisi()
          .yolculukGonderiBegen(widget.gonderi, _aktifKullaniciId);
    }
  }

  void _detaylarButonu() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xff141414),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  color: MelihColors().acikGri,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Sil'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Sil'),
                    onTap: null,
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Sil'),
                    onTap: null,
                  )
                ],
              ),
            ),
          );
        });
  }
}

class EsyaGonderiKarti extends StatefulWidget {
  final EsyaGonderi gonderi;
  final Kullanici yayinlayan;

  const EsyaGonderiKarti({Key key, this.gonderi, this.yayinlayan})
      : super(key: key);
  @override
  _EsyaGonderiKartiState createState() => _EsyaGonderiKartiState();
}

class _EsyaGonderiKartiState extends State<EsyaGonderiKarti> {
  int _begeniSayisi = 0;
  bool _begendin = false;
  String _aktifKullaniciId;

  @override
  void initState() {
    super.initState();
    _aktifKullaniciId =
        Provider.of<YetkilendirmeServisi>(context, listen: false)
            .aktifKullaniciId;
    _begeniSayisi = widget.gonderi.begeniSayisi;
    esyaBegeniVarMi();
  }

  esyaBegeniVarMi() async {
    bool esyaBegeniVarMi = await FirestoreServisi()
        .esyaBegeniVarMi(widget.gonderi, _aktifKullaniciId);
    if (esyaBegeniVarMi) {
      if (mounted) {
        setState(() {
          _begendin = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Container(
            decoration: BoxDecoration(
                color: MelihColors().acikacikGri,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: _width * 0.9,
            height: _height * 0.23,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: _height / 55,
                            backgroundImage:
                                NetworkImage(widget.yayinlayan.fotoUrl),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              widget.yayinlayan.kullaniciAdi,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: _height / 50),
                            ),
                          )
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Row(children: [
                        _aktifKullaniciId == widget.gonderi.yayinlayanId
                            ? IconButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  size: _height / 45,
                                  color: Colors.white,
                                ),
                                onPressed: () => _detaylarButonu())
                            : null
                      ]),
                    ],
                  ),
                ),
                Divider(
                  color: MelihColors().white.withOpacity(0.8),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.gonderi.baslik,
                        style: TextStyle(
                            color: MelihColors().white,
                            fontWeight: FontWeight.bold,
                            fontSize: _height / 55),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            child: IconButton(
                              onPressed: _begeniDegistir,
                              icon: !_begendin
                                  ? Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: _height / 35,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: _height / 35,
                                    ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: _height / 55),
                                  text: _begeniSayisi.toString()),
                              // TextSpan(
                              //     style: TextStyle(
                              //         color: Colors.white.withOpacity(0.8),
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: _height / 45),
                              //     text: ' beğeni'),
                            ]),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: InkWell(
                          onTap: () =>
                              print("Eşya gönderi detay sayfasına gidecek"),
                          child: RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                  child: Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Icon(
                                  FontAwesomeIcons.infoCircle,
                                  size: _height / 50,
                                  color: MelihColors().amber,
                                ),
                              )),
                              TextSpan(
                                text: '  Detaylar',
                                style: TextStyle(
                                    color: MelihColors().amber,
                                    fontWeight: FontWeight.bold,
                                    fontSize: _height / 55),
                              )
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _begeniDegistir() {
    if (_begendin) {
      setState(() {
        _begendin = false;
        _begeniSayisi = _begeniSayisi - 1;
      });
      FirestoreServisi()
          .esyaGonderiBegeniKaldir(widget.gonderi, _aktifKullaniciId);
    } else {
      setState(() {
        _begendin = true;
        _begeniSayisi = _begeniSayisi + 1;
      });
      FirestoreServisi().esyaGonderiBegen(widget.gonderi, _aktifKullaniciId);
    }
  }

  void _detaylarButonu() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xff141414),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  color: MelihColors().acikGri,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Sil'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Sil'),
                    onTap: null,
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Sil'),
                    onTap: null,
                  )
                ],
              ),
            ),
          );
        });
  }
}

class NotGonderiKarti extends StatefulWidget {
  final NotGonderi gonderi;
  final Kullanici yayinlayan;

  const NotGonderiKarti({Key key, this.gonderi, this.yayinlayan})
      : super(key: key);
  @override
  _NotGonderiKartiState createState() => _NotGonderiKartiState();
}

class _NotGonderiKartiState extends State<NotGonderiKarti> {
  int _begeniSayisi = 0;
  bool _begendin = false;
  String _aktifKullaniciId;

  @override
  void initState() {
    super.initState();
    _aktifKullaniciId =
        Provider.of<YetkilendirmeServisi>(context, listen: false)
            .aktifKullaniciId;
    _begeniSayisi = widget.gonderi.begeniSayisi;
    notBegeniVarMi();
  }

  notBegeniVarMi() async {
    bool notBegeniVarMi = await FirestoreServisi()
        .notBegeniVarMi(widget.gonderi, _aktifKullaniciId);
    if (notBegeniVarMi) {
      if (mounted) {
        setState(() {
          _begendin = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Container(
            decoration: BoxDecoration(
                color: MelihColors().acikacikGri,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: _width * 0.9,
            height: _height * 0.23,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: _height / 55,
                            backgroundImage:
                                NetworkImage(widget.yayinlayan.fotoUrl),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              widget.yayinlayan.kullaniciAdi,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: _height / 50),
                            ),
                          )
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Row(children: [
                        _aktifKullaniciId == widget.gonderi.yayinlayanId
                            ? IconButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  size: _height / 45,
                                  color: Colors.white,
                                ),
                                onPressed: () => _detaylarButonu())
                            : null
                      ]),
                    ],
                  ),
                ),
                Divider(
                  color: MelihColors().white.withOpacity(0.8),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.gonderi.baslik,
                        style: TextStyle(
                            color: MelihColors().white,
                            fontWeight: FontWeight.bold,
                            fontSize: _height / 55),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: _begeniDegistir,
                            icon: !_begendin
                                ? Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                    size: _height / 35,
                                  )
                                : Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: _height / 35,
                                  ),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: _height / 45),
                                  text: _begeniSayisi.toString()),
                              // TextSpan(
                              //     style: TextStyle(
                              //         color: Colors.white.withOpacity(0.8),
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: _height / 45),
                              //     text: ' beğeni'),
                            ]),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: InkWell(
                          onTap: () =>
                              print("Not gönderi detay sayfasına gidecek"),
                          child: RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                  child: Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Icon(
                                  FontAwesomeIcons.infoCircle,
                                  size: _height / 50,
                                  color: MelihColors().green,
                                ),
                              )),
                              TextSpan(
                                text: '  Detaylar',
                                style: TextStyle(
                                    color: MelihColors().green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: _height / 55),
                              )
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: _height * 0.01,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _begeniDegistir() {
    if (_begendin) {
      setState(() {
        _begendin = false;
        _begeniSayisi = _begeniSayisi - 1;
      });
      FirestoreServisi()
          .notGonderiBegeniKaldir(widget.gonderi, _aktifKullaniciId);
    } else {
      setState(() {
        _begendin = true;
        _begeniSayisi = _begeniSayisi + 1;
      });
      FirestoreServisi().notGonderiBegen(widget.gonderi, _aktifKullaniciId);
    }
  }

  void _detaylarButonu() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xff141414),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  color: MelihColors().acikGri,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Sil'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Sil'),
                    onTap: null,
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Sil'),
                    onTap: null,
                  )
                ],
              ),
            ),
          );
        });
  }
}
