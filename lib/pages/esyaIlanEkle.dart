import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';
import 'package:uludag_social/pages/ilanlar.dart';
import 'package:uludag_social/services/firestoreServisi.dart';
import 'package:uludag_social/services/storageServisi.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';

class EsyaIlanEkle extends StatefulWidget {
  @override
  _EsyaIlanEkleState createState() => _EsyaIlanEkleState();
}

class _EsyaIlanEkleState extends State<EsyaIlanEkle> {
  TextEditingController aciklamaTextKumandasi = TextEditingController();
  TextEditingController konumTextKumandasi = TextEditingController();
  TextEditingController baslikTextKumandasi = TextEditingController();
  TextEditingController kategoriTextKumandasi = TextEditingController();
  TextEditingController fiyatTextKumandasi = TextEditingController();

  final _formAnahtari = GlobalKey<FormState>();
  final _scaffoldAnahtari = GlobalKey<ScaffoldState>();
  File dosya;
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
        title: Text('Eşya İlanı Ekle'),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                dosya = null;
              });
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
                  AspectRatio(aspectRatio: 16.0 / 9.0, child: fotoYuklendiMi()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Theme(
                      data: ThemeData(primaryColor: MelihColors().amber),
                      child: TextFormField(
                        controller: baslikTextKumandasi,
                        cursorColor: MelihColors().amber,
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
                      data: ThemeData(primaryColor: MelihColors().amber),
                      child: TextFormField(
                        controller: aciklamaTextKumandasi,
                        cursorColor: MelihColors().amber,
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
                      data: ThemeData(primaryColor: MelihColors().amber),
                      child: TextFormField(
                        controller: kategoriTextKumandasi,
                        cursorColor: MelihColors().amber,
                        style: TextStyle(color: Colors.white),
                        validator: (girilenDeger) {
                          if (girilenDeger.isEmpty) {
                            return "Kategori alanı boş bırakılamaz";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: MelihColors().white),
                            labelText: 'Kategori'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Theme(
                      data: ThemeData(primaryColor: MelihColors().amber),
                      child: TextFormField(
                        controller: fiyatTextKumandasi,
                        cursorColor: MelihColors().amber,
                        style: TextStyle(color: Colors.white),
                        validator: (girilenDeger) {
                          if (girilenDeger.isEmpty) {
                            return "Fiyat alanı boş bırakılamaz";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: MelihColors().white),
                            labelText: 'Fiyat'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Theme(
                      data: ThemeData(primaryColor: MelihColors().amber),
                      child: TextFormField(
                        controller: konumTextKumandasi,
                        cursorColor: MelihColors().amber,
                        style: TextStyle(color: Colors.white),
                        validator: (girilenDeger) {
                          if (girilenDeger.isEmpty) {
                            return "Konum alanı boş bırakılamaz";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: MelihColors().white),
                            labelText: 'Konum'),
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
                        color: MelihColors().amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: esyaGonderiOlustur,
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

  fotografSec() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Resim Yükle"),
            children: <Widget>[
              SimpleDialogOption(
                child: Text("Fotoğraf Çek"),
                onPressed: () {
                  fotoCek();
                },
              ),
              SimpleDialogOption(
                child: Text("Galeriden Yükle"),
                onPressed: () {
                  galeridenSec();
                },
              ),
              SimpleDialogOption(
                child: Text("İptal"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  fotoCek() async {
    Navigator.pop(context);
    var image = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 80);
    setState(() {
      dosya = File(image.path);
    });
  }

  galeridenSec() async {
    Navigator.pop(context);
    var image = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 80);
    setState(() {
      dosya = File(image.path);
    });
  }

  Widget fotoYuklendiMi() {
    if (dosya == null) {
      return Stack(
        children: [
          Container(
            color: MelihColors().acikacikGri,
          ),
          Center(
              child: InkWell(
            onTap: () {
              fotografSec();
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.3,
              child: Center(child: Text('Fotoğraf Yükle')),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.grey),
            ),
          )),
        ],
      );
    } else {
      return Image.file(dosya);
    }
  }

  void esyaGonderiOlustur() async {
    var _formState = _formAnahtari.currentState;
    if (dosya == null) {
      var snackBar = SnackBar(content: Text("Lütfen bir fotoğraf yükleyin."));
      _scaffoldAnahtari.currentState.showSnackBar(snackBar);
    } else {
      if (!yukleniyor && _formState.validate()) {
        setState(() {
          yukleniyor = true;
        });

        String resimUrl = await StorageServisi().gonderiResmiYukle(dosya);
        String aktifKullaniciId =
            Provider.of<YetkilendirmeServisi>(context, listen: false)
                .aktifKullaniciId;

        await FirestoreServisi().esyaGonderiOlustur(
            yayinlayanId: aktifKullaniciId,
            gonderiResmiUrl: resimUrl,
            baslik: baslikTextKumandasi.text,
            aciklama: aciklamaTextKumandasi.text,
            konum: konumTextKumandasi.text,
            kategori: kategoriTextKumandasi.text,
            fiyat: fiyatTextKumandasi.text);

        setState(() {
          yukleniyor = false;
          baslikTextKumandasi.clear();
          fiyatTextKumandasi.clear();
          kategoriTextKumandasi.clear();
          aciklamaTextKumandasi.clear();
          konumTextKumandasi.clear();
          dosya = null;
        });
        Navigator.pop(context);
      }
    }
  }
}
