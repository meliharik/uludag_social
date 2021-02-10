import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';
import 'package:uludag_social/models/kullanici.dart';
import 'package:uludag_social/pages/hesapOlustur.dart';
import 'package:uludag_social/pages/sifremiUnuttum.dart';
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
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: MelihColors().koyuGri,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: MelihColors().main,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLogo(),
              _buildContainer(),
              _buildSignUpBtn(),
            ],
          )
        ],
      ),
    );
    // return Form(
    //   key: _formAnahtari,
    //   child: ListView(
    //     padding: EdgeInsets.only(left: 20, right: 20, top: 20),
    //     children: [
    //       FlutterLogo(
    //         size: 90,
    //       ),
    //       SizedBox(
    //         height: 80,
    //       ),
    //       TextFormField(
    //         keyboardType: TextInputType.emailAddress,
    //         decoration: InputDecoration(
    //             filled: true,
    //             labelText: "Email",
    //             hintText: "Email adresinizi girin",
    //             errorStyle: TextStyle(fontSize: 16),
    //             prefixIcon: Icon(Icons.mail)),
    //         validator: (girilenDeger) {
    //           if (girilenDeger.isEmpty) {
    //             return "Email alanı boş bırakılamaz";
    //           } else if (!girilenDeger.contains("@")) {
    //             return "Girilen değer mali formatında olmalı";
    //           }
    //           return null;
    //         },
    //         onSaved: (girilenDeger) {
    //           email = girilenDeger;
    //         },
    //       ),
    //       SizedBox(
    //         height: 40,
    //       ),
    //       TextFormField(
    //         onSaved: (girilenDeger) {
    //           sifre = girilenDeger;
    //         },
    //         validator: (girilenDeger) {
    //           if (girilenDeger.isEmpty) {
    //             return "Şifre alanı boş bırakılamaz";
    //           } else if (girilenDeger.trim().length < 4) {
    //             return "Şifre 4 karakterden az olamaz";
    //           }
    //           return null;
    //         },
    //         obscureText: _obscureText,
    //         decoration: InputDecoration(
    //             filled: true,
    //             hintText: 'Şifrenizi girin',
    //             errorStyle: TextStyle(fontSize: 16),
    //             labelText: 'Parola',
    //             prefixIcon: Icon(Icons.lock),
    //             suffixIcon: GestureDetector(
    //               dragStartBehavior: DragStartBehavior.down,
    //               onTap: () {
    //                 setState(() {
    //                   _obscureText = !_obscureText;
    //                 });
    //               },
    //               child: Icon(
    //                   _obscureText ? Icons.visibility : Icons.visibility_off),
    //             )),
    //       ),
    //       SizedBox(
    //         height: 40,
    //       ),
    //       Row(
    //         children: [
    //           Expanded(
    //             child: FlatButton(
    //                 color: Theme.of(context).primaryColor,
    //                 onPressed: () {
    //                   Navigator.of(context).push(MaterialPageRoute(
    //                       builder: (context) => HesapOlustur()));
    //                 },
    //                 child: Text('Hesap Oluştur')),
    //           ),
    //           SizedBox(
    //             width: 15,
    //           ),
    //           Expanded(
    //             child: FlatButton(
    //                 color: Theme.of(context).primaryColor,
    //                 onPressed: _girisYap,
    //                 child: Text('Giriş Yap')),
    //           )
    //         ],
    //       ),
    //       SizedBox(
    //         height: 20,
    //       ),
    //       Center(child: Text('veya')),
    //       SizedBox(
    //         height: 20,
    //       ),
    //       Center(
    //           child: InkWell(
    //         onTap: _googleIleGiris,
    //         child: Text(
    //           "Google İle Giriş Yap",
    //           style: TextStyle(
    //             fontSize: 19.0,
    //             fontWeight: FontWeight.bold,
    //             color: Colors.grey[600],
    //           ),
    //         ),
    //       )),
    //       SizedBox(
    //         height: 20,
    //       ),
    //       Center(child: Text('Şifremi Unuttum')),
    //     ],
    //   ),
    // );
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
        height: MediaQuery.of(context).size.height * 0.63,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: MelihColors().acikacikGri,
        ),
        child: Form(
          key: _formAnahtari,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildEmailRow(),
              _buildPasswordRow(),
              _buildForgetPasswordButton(),
              _buildLoginButton(),
              _buildOrRow(),
              _buildSocialBtnRow(),
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
                  MaterialPageRoute(builder: (context) => HesapOlustur()));
            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Henüz hesabın yok mu? ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height / 50,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: ' Hesap Oluştur',
                  style: TextStyle(
                    color: MelihColors().main,
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

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
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
              color: MelihColors().main,
            ),
            labelText: 'E-mail'),
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.text,
        obscureText: _obscureText,
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
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          labelStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(
            Icons.lock,
            color: MelihColors().main,
          ),
          labelText: 'Parola',
        ),
      ),
    );
  }

  Widget _buildForgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SifremiUnuttum()));
          },
          child: Text(
            "Şifremi Unuttum",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: MelihColors().main,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: _girisYap,
            child: Text(
              "Giriş Yap",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(color: Colors.white),
          ),
        ),
        Text(
          ' Veya ',
          style: TextStyle(color: Colors.white),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 6.5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(top: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: MelihColors().main,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: _googleIleGiris,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                ),
                Text(
                  "Google ile Giriş Yap",
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: MediaQuery.of(context).size.height / 40,
                  ),
                ),
              ],
            ),
          ),
        ),
        // GestureDetector(
        //   onTap: () {},
        //   child: Container(
        //     height: 60,
        //     width: 60,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: MelihColors().main,
        //       boxShadow: [
        //         BoxShadow(
        //             color: Colors.black26,
        //             offset: Offset(0, 2),
        //             blurRadius: 6.0)
        //       ],
        //     ),
        //     child: Icon(
        //       FontAwesomeIcons.google,
        //       color: Colors.white,
        //     ),
        //   ),
        // )
      ],
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
