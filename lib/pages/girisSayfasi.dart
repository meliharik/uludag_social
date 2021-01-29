import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/kullanici.dart';
import 'package:uludag_social/pages/hesapOlustur.dart';
import 'package:uludag_social/services/firestoreServisi.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';

class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  final _formAnahtari = GlobalKey<FormState>();
  final _scaffoldAnahtari = GlobalKey<ScaffoldState>();
  bool _obscureText = true;
  bool yukleniyor = false;
  String email, sifre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldAnahtari,
        body: Stack(
          children: [
            _sayfaElemanlari(),
            _yuklemeAnimasyonu(),
          ],
        ));
  }

  _yuklemeAnimasyonu() {
    if (yukleniyor) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _sayfaElemanlari() {
    return Form(
      key: _formAnahtari,
      child: ListView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        children: [
          FlutterLogo(
            size: 90,
          ),
          SizedBox(
            height: 80,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                filled: true,
                labelText: "Email",
                hintText: "Email adresinizi girin",
                errorStyle: TextStyle(fontSize: 16),
                prefixIcon: Icon(Icons.mail)),
            validator: (girilenDeger) {
              if (girilenDeger.isEmpty) {
                return "Email alanı boş bırakılamaz";
              } else if (!girilenDeger.contains("@")) {
                return "Girilen değer mali formatında olmalı";
              }
              return null;
            },
            onSaved: (girilenDeger) {
              email = girilenDeger;
            },
          ),
          SizedBox(
            height: 40,
          ),
          TextFormField(
            onSaved: (girilenDeger) {
              sifre = girilenDeger;
            },
            validator: (girilenDeger) {
              if (girilenDeger.isEmpty) {
                return "Şifre alanı boş bırakılamaz";
              } else if (girilenDeger.trim().length < 4) {
                return "Şifre 4 karakterden az olamaz";
              }
              return null;
            },
            obscureText: _obscureText,
            decoration: InputDecoration(
                filled: true,
                hintText: 'Şifrenizi girin',
                errorStyle: TextStyle(fontSize: 16),
                labelText: 'Parola',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                )),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HesapOlustur()));
                    },
                    child: Text('Hesap Oluştur')),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _girisYap,
                    child: Text('Giriş Yap')),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(child: Text('veya')),
          SizedBox(
            height: 20,
          ),
          Center(
              child: InkWell(
            onTap: _googleIleGiris,
            child: Text(
              "Google İle Giriş Yap",
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          )),
          SizedBox(
            height: 20,
          ),
          Center(child: Text('Şifremi Unuttum')),
        ],
      ),
    );
  }

  void _girisYap() async {
    final _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);

    if (_formAnahtari.currentState.validate()) {
      _formAnahtari.currentState.save();
      setState(() {
        yukleniyor = true;
      });
      try {
        await _yetkilendirmeServisi.mailIleGiris(email, sifre);
      } catch (hata) {
        setState(() {
          yukleniyor = false;
        });
        uyariGoster(hataKodu: hata.code);
      }
    }
  }

  void _googleIleGiris() async {
    var _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);

    setState(() {
      yukleniyor = true;
    });

    try {
      Kullanici kullanici = await _yetkilendirmeServisi.googleIleGiris();
      if (kullanici != null) {
        Kullanici firestoreKullanici =
            await FirestoreServisi().kullaniciGetir(kullanici.id);
        if (firestoreKullanici == null) {
          FirestoreServisi().kullaniciOlustur(
              id: kullanici.id,
              email: kullanici.email,
              kullaniciAdi: kullanici.kullaniciAdi,
              fotoUrl: kullanici.fotoUrl);
        }
      }
    } catch (hata) {
      setState(() {
        yukleniyor = false;
      });
      uyariGoster(hataKodu: hata.code);
    }
  }

  uyariGoster({hataKodu}) {
    String hataMesaji;

    if (hataKodu == "user-not-found") {
      hataMesaji = "Böyle bir kullanıcı bulunmuyor";
    } else if (hataKodu == "invalid-email") {
      hataMesaji = "Girdiğiniz mail adresi geçersizdir";
    } else if (hataKodu == "wrong-password") {
      hataMesaji = "Girilen şifre hatalı";
    } else if (hataKodu == "user-disabled") {
      hataMesaji = "Kullanıcı engellenmiş";
    } else {
      hataMesaji = "Tanımlanamayan bir hata oluştu: $hataKodu";
    }

    var snackBar = SnackBar(content: Text(hataMesaji));
    _scaffoldAnahtari.currentState.showSnackBar(snackBar);
  }
}
