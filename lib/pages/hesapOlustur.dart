import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/kullanici.dart';
import 'package:uludag_social/services/firestoreServisi.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';

class HesapOlustur extends StatefulWidget {
  @override
  _HesapOlusturState createState() => _HesapOlusturState();
}

class _HesapOlusturState extends State<HesapOlustur> {
  bool yukleniyor = false;
  bool _obscureText = true;
  final _formAnahtari = GlobalKey<FormState>();
  final _scaffoldAnahtari = GlobalKey<ScaffoldState>();
  String kullaniciAdi, email, sifre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldAnahtari,
      appBar: AppBar(
        title: Text('Hesap Oluştur'),
      ),
      body: ListView(
        children: [
          yukleniyor
              ? LinearProgressIndicator()
              : SizedBox(
                  height: 0,
                ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formAnahtari,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        labelText: "Kullanıcı Adı",
                        hintText: "Kullanıcı adınızı girin",
                        errorStyle: TextStyle(fontSize: 16),
                        prefixIcon: Icon(Icons.person)),
                    validator: (girilenDeger) {
                      if (girilenDeger.isEmpty) {
                        return "Kullanıcı adı boş bırakılamaz";
                      } else if (girilenDeger.trim().length < 4 ||
                          girilenDeger.trim().length > 10) {
                        return "En az 4 en fazla 10 karakter olabilir";
                      }
                      return null;
                    },
                    onSaved: (girilenDeger) {
                      kullaniciAdi = girilenDeger;
                    },
                  ),
                  SizedBox(
                    height: 40,
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
                        return "Girilen değer email formatında olmalı";
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
                          child: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: _kullaniciOlustur,
                        child: Text('Hesap Oluştur')),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _kullaniciOlustur() async {
    final _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);

    var _formState = _formAnahtari.currentState;

    if (_formState.validate()) {
      _formState.save();
      setState(() {
        yukleniyor = true;
      });
      try {
        Kullanici kullanici =
            await _yetkilendirmeServisi.mailIleKayit(email, sifre);
        if (kullanici != null) {
          FirestoreServisi().kullaniciOlustur(
              id: kullanici.id,
              email: kullanici.email,
              kullaniciAdi: kullaniciAdi);
        }
        Navigator.pop(context);
      } catch (hata) {
        setState(() {
          yukleniyor = false;
        });
        uyariGoster(hataKodu: hata.code);
      }
    }
  }

  uyariGoster({hataKodu}) {
    String hataMesaji;

    if (hataKodu == "invalid-email") {
      hataMesaji = "Girdiğiniz mail adresi geçersizdir";
    } else if (hataKodu == "email-already-in-use") {
      hataMesaji = "Girdiğiniz mail kayıtlıdır";
    } else if (hataKodu == "weak-password") {
      hataMesaji = "Daha zor bir şifre tercih edin";
    }

    var snackBar = SnackBar(content: Text(hataMesaji));
    _scaffoldAnahtari.currentState.showSnackBar(snackBar);
  }
}
