import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';
import 'package:uludag_social/services/firestoreServisi.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';

class YolculukIlanEkle extends StatefulWidget {
  @override
  _YolculukIlanEkleState createState() => _YolculukIlanEkleState();
}

class _YolculukIlanEkleState extends State<YolculukIlanEkle> {
  TextEditingController aciklamaTextKumandasi = TextEditingController();
  TextEditingController nereyeTextKumandasi = TextEditingController();
  TextEditingController baslikTextKumandasi = TextEditingController();
  TextEditingController tarihTextKumandasi = TextEditingController();
  TextEditingController saatTextKumandasi = TextEditingController();
  TextEditingController neredenTextKumandasi = TextEditingController();

  final _formAnahtari = GlobalKey<FormState>();
  final _scaffoldAnahtari = GlobalKey<ScaffoldState>();
  bool yukleniyor = false;
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldAnahtari,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: MelihColors().acikGri,
      appBar: AppBar(
        title: Text('Yolculuk İlanı Ekle'),
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
            child: Form(
              key: _formAnahtari,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Theme(
                      data: ThemeData(primaryColor: MelihColors().red),
                      child: TextFormField(
                        controller: baslikTextKumandasi,
                        cursorColor: MelihColors().red,
                        style: TextStyle(color: Colors.white),
                        validator: (girilenDeger) {
                          if (girilenDeger.isEmpty) {
                            return "Başlık boş bırakılamaz";
                          } else if (girilenDeger.trim().length < 4) {
                            return "Çok kısa bir başlık girdiniz";
                          } else if (girilenDeger.trim().length > 50) {
                            return "Başlık en fazla 50 karakter olabilir";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: MelihColors().white),
                            labelText: 'Başlık'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Theme(
                      data: ThemeData(primaryColor: MelihColors().red),
                      child: TextFormField(
                        controller: aciklamaTextKumandasi,
                        cursorColor: MelihColors().red,
                        style: TextStyle(color: Colors.white),
                        validator: (girilenDeger) {
                          if (girilenDeger.isEmpty) {
                            return "Açıklama boş bırakılamaz";
                          } else if (girilenDeger.trim().length < 4) {
                            return "Çok kısa bir Açıklama girdiniz";
                          } else if (girilenDeger.trim().length > 150) {
                            return "Açıklama en fazla 150 karakter olabilir";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: MelihColors().white),
                            labelText: 'Açıklama'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Theme(
                      data: ThemeData(primaryColor: MelihColors().red),
                      child: TextFormField(
                        controller: neredenTextKumandasi,
                        cursorColor: MelihColors().red,
                        style: TextStyle(color: Colors.white),
                        validator: (girilenDeger) {
                          if (girilenDeger.isEmpty) {
                            return "Nereden alanı boş bırakılamaz";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: MelihColors().white),
                            labelText: 'Nereden'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Theme(
                      data: ThemeData(primaryColor: MelihColors().red),
                      child: TextFormField(
                        controller: nereyeTextKumandasi,
                        cursorColor: MelihColors().red,
                        style: TextStyle(color: Colors.white),
                        validator: (girilenDeger) {
                          if (girilenDeger.isEmpty) {
                            return "Nereye alanı boş bırakılamaz";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: MelihColors().white),
                            labelText: 'Nereye'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Theme(
                      data: ThemeData(primaryColor: MelihColors().red),
                      child: TextFormField(
                        controller: tarihTextKumandasi,
                        cursorColor: MelihColors().red,
                        style: TextStyle(color: Colors.white),
                        validator: (girilenDeger) {
                          if (girilenDeger.isEmpty) {
                            return "Tarih alanı boş bırakılamaz";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: MelihColors().white),
                            labelText: 'Tarih'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Theme(
                      data: ThemeData(primaryColor: MelihColors().red),
                      child: TextFormField(
                        controller: saatTextKumandasi,
                        cursorColor: MelihColors().red,
                        style: TextStyle(color: Colors.white),
                        validator: (girilenDeger) {
                          if (girilenDeger.isEmpty) {
                            return "Saat alanı boş bırakılamaz";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: MelihColors().white),
                            labelText: 'Saat'),
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
                        color: MelihColors().red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: yolculukGonderiOlustur,
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
          ),
        ],
      ),
    );
  }

  void yolculukGonderiOlustur() async {
    var _formState = _formAnahtari.currentState;
    if (!yukleniyor && _formState.validate()) {
      setState(() {
        yukleniyor = true;
      });

      String aktifKullaniciId =
          Provider.of<YetkilendirmeServisi>(context, listen: false)
              .aktifKullaniciId;

      await FirestoreServisi().yolculukGonderiOlustur(
          yayinlayanId: aktifKullaniciId,
          nereden: neredenTextKumandasi.text,
          baslik: baslikTextKumandasi.text,
          aciklama: aciklamaTextKumandasi.text,
          nereye: nereyeTextKumandasi.text,
          tarih: tarihTextKumandasi.text,
          saat: saatTextKumandasi.text);

      setState(() {
        yukleniyor = false;
        baslikTextKumandasi.clear();
        saatTextKumandasi.clear();
        tarihTextKumandasi.clear();
        aciklamaTextKumandasi.clear();
        nereyeTextKumandasi.clear();
        neredenTextKumandasi.clear();
      });
      Navigator.pop(context);
    }
  }
}
