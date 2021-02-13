import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';
import 'package:uludag_social/services/firestoreServisi.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';

class NotIlanEkle extends StatefulWidget {
  @override
  _NotIlanEkleState createState() => _NotIlanEkleState();
}

class _NotIlanEkleState extends State<NotIlanEkle> {
  TextEditingController aciklamaTextKumandasi = TextEditingController();
  TextEditingController dersTextKumandasi = TextEditingController();
  TextEditingController baslikTextKumandasi = TextEditingController();
  TextEditingController dersinHocasiTextKumandasi = TextEditingController();
  TextEditingController sayfaSayisiTextKumandasi = TextEditingController();
  TextEditingController bolumTextKumandasi = TextEditingController();
  TextEditingController fiyatTextKumandasi = TextEditingController();
  bool yukleniyor = false;
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: MelihColors().acikGri,
      appBar: AppBar(
        title: Text('Not İlanı Ekle'),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
        backgroundColor: MelihColors().acikGri,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          yukleniyor
              ? Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: 0,
                ),
          SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Theme(
                    data: ThemeData(primaryColor: MelihColors().green),
                    child: TextFormField(
                      controller: baslikTextKumandasi,
                      cursorColor: MelihColors().green,
                      style: TextStyle(color: Colors.white),
                      // validator: (girilenDeger) {
                      //   if (girilenDeger.isEmpty) {
                      //     return "Başlık boş bırakılamaz";
                      //   } else if (girilenDeger.trim().length < 4) {
                      //     return "Çok kısa bir başlık girdiniz";
                      //   } else if (girilenDeger.trim().length > 50) {
                      //     return "Başlık en fazla 50 karakter olabilir";
                      //   }
                      //   return null;
                      // },
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: MelihColors().white),
                          labelText: 'Başlık'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Theme(
                    data: ThemeData(primaryColor: MelihColors().green),
                    child: TextFormField(
                      controller: aciklamaTextKumandasi,
                      cursorColor: MelihColors().green,
                      style: TextStyle(color: Colors.white),
                      // validator: (girilenDeger) {
                      //   if (girilenDeger.isEmpty) {
                      //     return "Açıklama boş bırakılamaz";
                      //   } else if (girilenDeger.trim().length < 4) {
                      //     return "Çok kısa bir Açıklama girdiniz";
                      //   } else if (girilenDeger.trim().length > 150) {
                      //     return "Açıklama en fazla 150 karakter olabilir";
                      //   }
                      //   return null;
                      // },
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: MelihColors().white),
                          labelText: 'Açıklama'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Theme(
                    data: ThemeData(primaryColor: MelihColors().green),
                    child: TextFormField(
                      controller: bolumTextKumandasi,
                      cursorColor: MelihColors().green,
                      style: TextStyle(color: Colors.white),
                      // validator: (girilenDeger) {
                      //   if (girilenDeger.isEmpty) {
                      //     return "Konum alanı boş bırakılamaz";
                      //   }
                      //   return null;
                      // },
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: MelihColors().white),
                          labelText: 'Bölüm'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Theme(
                    data: ThemeData(primaryColor: MelihColors().green),
                    child: TextFormField(
                      controller: dersTextKumandasi,
                      cursorColor: MelihColors().green,
                      style: TextStyle(color: Colors.white),
                      // validator: (girilenDeger) {
                      //   if (girilenDeger.isEmpty) {
                      //     return "Konum alanı boş bırakılamaz";
                      //   }
                      //   return null;
                      // },
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: MelihColors().white),
                          labelText: 'Ders'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Theme(
                    data: ThemeData(primaryColor: MelihColors().green),
                    child: TextFormField(
                      controller: dersinHocasiTextKumandasi,
                      cursorColor: MelihColors().green,
                      style: TextStyle(color: Colors.white),
                      // validator: (girilenDeger) {
                      //   if (girilenDeger.isEmpty) {
                      //     return "Bu alan boş bırakılamaz";
                      //   }
                      //   return null;
                      // },
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: MelihColors().white),
                          labelText: 'Dersin Hocası'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Theme(
                    data: ThemeData(primaryColor: MelihColors().green),
                    child: TextFormField(
                      controller: sayfaSayisiTextKumandasi,
                      cursorColor: MelihColors().green,
                      style: TextStyle(color: Colors.white),
                      // validator: (girilenDeger) {
                      //   if (girilenDeger.isEmpty) {
                      //     return "Kira alanı boş bırakılamaz";
                      //   }
                      //   return null;
                      // },
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: MelihColors().white),
                          labelText: 'Sayfa Sayısı'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Theme(
                    data: ThemeData(primaryColor: MelihColors().green),
                    child: TextFormField(
                      controller: fiyatTextKumandasi,
                      cursorColor: MelihColors().green,
                      style: TextStyle(color: Colors.white),
                      // validator: (girilenDeger) {
                      //   if (girilenDeger.isEmpty) {
                      //     return "Kira alanı boş bırakılamaz";
                      //   }
                      //   return null;
                      // },
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: MelihColors().white),
                          labelText: 'Fiyat'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: _height * 0.07,
                    width: _width * 0.35,
                    child: RaisedButton(
                      elevation: 5.0,
                      color: MelihColors().green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: notGonderiOlustur,
                      child: Text(
                        "İlanı Oluştur",
                        style: TextStyle(
                          color: MelihColors().koyuGri,
                          letterSpacing: 1.5,
                          fontSize: MediaQuery.of(context).size.height / 40,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void notGonderiOlustur() async {
    if (!yukleniyor) {
      setState(() {
        yukleniyor = true;
      });

      String aktifKullaniciId =
          Provider.of<YetkilendirmeServisi>(context, listen: false)
              .aktifKullaniciId;

      await FirestoreServisi().notGonderiOlustur(
          yayinlayanId: aktifKullaniciId,
          bolum: bolumTextKumandasi.text,
          baslik: baslikTextKumandasi.text,
          aciklama: aciklamaTextKumandasi.text,
          ders: dersTextKumandasi.text,
          dersinHocasi: dersinHocasiTextKumandasi.text,
          fiyat: fiyatTextKumandasi.text,
          sayfaSayisi: sayfaSayisiTextKumandasi.text);

      setState(() {
        yukleniyor = false;
        baslikTextKumandasi.clear();
        sayfaSayisiTextKumandasi.clear();
        dersinHocasiTextKumandasi.clear();
        aciklamaTextKumandasi.clear();
        dersTextKumandasi.clear();
        bolumTextKumandasi.clear();
        fiyatTextKumandasi.clear();
      });
      Navigator.pop(context);
    }
  }
}
