import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';
import 'package:uludag_social/models/kullanici.dart';
import 'package:uludag_social/pages/ilanlar.dart';
import 'package:uludag_social/pages/anaSayfa.dart';
import 'package:uludag_social/pages/girisSayfasi.dart';
import 'package:uludag_social/services/firestoreServisi.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';

class HesapOlustur extends StatefulWidget {
  @override
  _HesapOlusturState createState() => _HesapOlusturState();
}

class _HesapOlusturState extends State<HesapOlustur> {
  bool yukleniyor = false;
  bool _obscureText = true;
  bool _obscureText2 = true;
  final _formAnahtari = GlobalKey<FormState>();
  final _scaffoldAnahtari = GlobalKey<ScaffoldState>();
  String kullaniciAdi, email, sifre, sifre2;
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MelihColors().koyuGri,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      key: _scaffoldAnahtari,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: MelihColors().amber,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              yukleniyor
                  ? LinearProgressIndicator()
                  : SizedBox(
                      height: 0,
                    ),
              _buildLogo(),
              _buildContainer(),
              _buildSignUpBtn(),
            ],
          )
        ],
      ),
      // body: ListView(
      //   children: [
      //     yukleniyor
      //         ? LinearProgressIndicator()
      //         : SizedBox(
      //             height: 0,
      //           ),
      //     SizedBox(
      //       height: 20,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: Form(
      //         key: _formAnahtari,
      //         child: Column(
      //           children: [
      //             TextFormField(
      //               decoration: InputDecoration(
      //                   filled: true,
      //                   labelText: "Kullanıcı Adı",
      //                   hintText: "Kullanıcı adınızı girin",
      //                   errorStyle: TextStyle(fontSize: 16),
      //                   prefixIcon: Icon(Icons.person)),
      //               validator: (girilenDeger) {
      //                 if (girilenDeger.isEmpty) {
      //                   return "Kullanıcı adı boş bırakılamaz";
      //                 } else if (girilenDeger.trim().length < 4 ||
      //                     girilenDeger.trim().length > 10) {
      //                   return "En az 4 en fazla 10 karakter olabilir";
      //                 }
      //                 return null;
      //               },
      //               onSaved: (girilenDeger) {
      //                 kullaniciAdi = girilenDeger;
      //               },
      //             ),
      //             SizedBox(
      //               height: 40,
      //             ),
      //             TextFormField(
      //               keyboardType: TextInputType.emailAddress,
      //               decoration: InputDecoration(
      //                   filled: true,
      //                   labelText: "Email",
      //                   hintText: "Email adresinizi girin",
      //                   errorStyle: TextStyle(fontSize: 16),
      //                   prefixIcon: Icon(Icons.mail)),
      //               validator: (girilenDeger) {
      //                 if (girilenDeger.isEmpty) {
      //                   return "Email alanı boş bırakılamaz";
      //                 } else if (!girilenDeger.contains("@")) {
      //                   return "Girilen değer email formatında olmalı";
      //                 }
      //                 return null;
      //               },
      //               onSaved: (girilenDeger) {
      //                 email = girilenDeger;
      //               },
      //             ),
      //             SizedBox(
      //               height: 40,
      //             ),
      //             TextFormField(
      //               onSaved: (girilenDeger) {
      //                 sifre = girilenDeger;
      //               },
      //               validator: (girilenDeger) {
      //                 if (girilenDeger.isEmpty) {
      //                   return "Şifre alanı boş bırakılamaz";
      //                 } else if (girilenDeger.trim().length < 4) {
      //                   return "Şifre 4 karakterden az olamaz";
      //                 }
      //                 return null;
      //               },
      //               obscureText: _obscureText,
      //               decoration: InputDecoration(
      //                   filled: true,
      //                   hintText: 'Şifrenizi girin',
      //                   errorStyle: TextStyle(fontSize: 16),
      //                   labelText: 'Parola',
      //                   prefixIcon: Icon(Icons.lock),
      //                   suffixIcon: GestureDetector(
      //                     dragStartBehavior: DragStartBehavior.down,
      //                     onTap: () {
      //                       setState(() {
      //                         _obscureText = !_obscureText;
      //                       });
      //                     },
      //                     child: Icon(_obscureText
      //                         ? Icons.visibility
      //                         : Icons.visibility_off),
      //                   )),
      //             ),
      //             SizedBox(
      //               height: 50,
      //             ),
      //             Container(
      //               width: double.infinity,
      //               child: FlatButton(
      //                   color: Theme.of(context).primaryColor,
      //                   onPressed: _kullaniciOlustur,
      //                   child: Text('Hesap Oluştur')),
      //             ),
      //           ],
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            'Uludağ Social',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: MelihColors().acikacikGri,
        ),
        child: Form(
          key: _formAnahtari,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildKullaniciAdiRow(),
              _buildEmailRow(),
              _buildPasswordRow(),
              _buildPassword2Row(),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => GirisSayfasi()));
            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Zaten hesabın var mı? ',
                  style: TextStyle(
                    color: MelihColors().acikGri,
                    fontSize: MediaQuery.of(context).size.height / 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: ' Giriş Yap',
                  style: TextStyle(
                    color: MelihColors().koyuGri,
                    fontSize: MediaQuery.of(context).size.height / 40,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKullaniciAdiRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Theme(
        data: ThemeData(primaryColor: MelihColors().amber),
        child: TextFormField(
          cursorColor: MelihColors().amber,
          style: TextStyle(color: Colors.white),
          validator: (girilenDeger) {
            if (girilenDeger.isEmpty) {
              return "Kullanıcı Adı boş bırakılamaz";
            } else if (girilenDeger.trim().length < 4 ||
                girilenDeger.trim().length > 11) {
              return "En az 4 en çok 10 karakter olabilir";
            }
            return null;
          },
          onSaved: (girilenDeger) {
            kullaniciAdi = girilenDeger;
          },
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.person,
                color: MelihColors().amber,
              ),
              labelText: 'Kullanıcı Adı'),
        ),
      ),
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Theme(
        data: ThemeData(primaryColor: MelihColors().amber),
        child: TextFormField(
          cursorColor: MelihColors().amber,
          style: TextStyle(color: Colors.white),
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
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.email,
                color: MelihColors().amber,
              ),
              labelText: 'E-mail'),
        ),
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Theme(
        data: ThemeData(primaryColor: MelihColors().amber),
        child: TextFormField(
          controller: _pass,
          cursorColor: MelihColors().amber,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          obscureText: _obscureText,
          onSaved: (girilenDeger) {
            sifre = girilenDeger;
          },
          validator: (girilenDeger) {
            if (girilenDeger.isEmpty) {
              return "Parola alanı boş bırakılamaz";
            } else if (girilenDeger.trim().length < 4) {
              return "parola 4 karakterden az olamaz";
            }
            return null;
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(
              Icons.lock,
              color: MelihColors().amber,
            ),
            labelText: 'Parola',
          ),
        ),
      ),
    );
  }

  Widget _buildPassword2Row() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Theme(
        data: ThemeData(primaryColor: MelihColors().amber),
        child: TextFormField(
          controller: _confirmPass,
          cursorColor: MelihColors().amber,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          obscureText: _obscureText2,
          onSaved: (girilenDeger) {
            sifre2 = girilenDeger;
          },
          validator: (girilenDeger) {
            if (girilenDeger != _pass.text) {
              return "Girilen parolalar aynı değil";
            }
            return null;
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText2 ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText2 = !_obscureText2;
                });
              },
            ),
            labelStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(
              Icons.lock,
              color: MelihColors().amber,
            ),
            labelText: 'Parolayı onaylayın',
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 5),
          child: RaisedButton(
            elevation: 5.0,
            color: MelihColors().amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: _kullaniciOlustur,
            child: Text(
              "Hesap Oluştur",
              style: TextStyle(
                color: MelihColors().koyuGri,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
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
            kullaniciAdi: kullaniciAdi,
          );
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
