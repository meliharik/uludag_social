
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';

class SifremiUnuttum extends StatefulWidget {
  @override
  _SifremiUnuttumState createState() => _SifremiUnuttumState();
}

class _SifremiUnuttumState extends State<SifremiUnuttum> {
  final _formAnahtari = GlobalKey<FormState>();
  final _scaffoldAnahtari = GlobalKey<ScaffoldState>();
  bool yukleniyor = false;
  String email;

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MelihColors().koyuGri,
      ),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: MelihColors().koyuGri,
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
                    color: MelihColors().red,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              _buildContainer(),
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
          padding: const EdgeInsets.all(0),
          child: Text(
            'Şifremi Yenile',
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/lock.png",
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  _buildLogo(),
                  _buildEmailRow(),
                  _infoText(),
                  _buildLoginButton(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Theme(
        data: ThemeData(primaryColor: MelihColors().red),
        child: TextFormField(
          cursorColor: MelihColors().red,
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
                color: MelihColors().red,
              ),
              labelText: 'E-mail'),
        ),
      ),
    );
  }

  Widget _infoText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(children: [
          WidgetSpan(
              child: Icon(
            Icons.info_outline,
            color: Colors.white,
            size: MediaQuery.of(context).size.height / 40,
          )),
          TextSpan(
              text:
                  " Emailinize gelen linke basarak şifrenizi yenileyebilirsiniz.",
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.height / 50)),
        ]),
      ),
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
            color: MelihColors().red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: _sifreyiSifirla,
            child: Text(
              "Şifremi Sıfırla",
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

  void _sifreyiSifirla() async {
    final _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);

    var _formState = _formAnahtari.currentState;

    if (_formState.validate()) {
      _formState.save();
      setState(() {
        yukleniyor = true;
      });

      try {
        await _yetkilendirmeServisi.sifremiSifirla(email);
        setState(() {
          yukleniyor = false;
        });
        showAlertDialog(context);
      } catch (hata) {
        setState(() {
          yukleniyor = false;
        });
        uyariGoster(hataKodu: hata.code);
      }
    }
  }

//---------------SUCCESS------------------

  showAlertDialog(BuildContext context) {
    //button
    Widget okButton = FlatButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      elevation: 5,
      backgroundColor: MelihColors().acikGri,
      title: Text(
        "İşlem tamam",
        style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
      ),
      content: Text(
        "E-mailine parola sıfırlama linki gönderildi.",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:uludag_social/models/colorsAndTypes.dart';
// import 'package:uludag_social/services/yetkilendirmeServisi.dart';

// class SifremiUnuttum extends StatefulWidget {
//   @override
//   _SifremiUnuttumState createState() => _SifremiUnuttumState();
// }

// class _SifremiUnuttumState extends State<SifremiUnuttum> {
//   bool yukleniyor = false;
//   final _formAnahtari = GlobalKey<FormState>();
//   final _scaffoldAnahtari = GlobalKey<ScaffoldState>();
//   String email;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         //resizeToAvoidBottomInset: false,
//         resizeToAvoidBottomPadding: false,
//         backgroundColor: MelihColors().koyuGri,
//         key: _scaffoldAnahtari,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: MelihColors().koyuGri,
//           title: Text("Şifreni Sıfırla"),
//         ),
//         body: Stack(
//           children: [
//             yukleniyor
//                 ? LinearProgressIndicator()
//                 : SizedBox(
//                     height: 0.0,
//                   ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.6,
//                   width: MediaQuery.of(context).size.width,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: MelihColors().red,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(70),
//                         topRight: Radius.circular(70),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.1,
//                   ),
//                   ClipRRect(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(20),
//                     ),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * 0.55,
//                       width: MediaQuery.of(context).size.width * 0.8,
//                       decoration: BoxDecoration(
//                         color: MelihColors().acikacikGri,
//                       ),
//                       child: Form(
//                         key: _formAnahtari,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             Image.asset(
//                               "assets/images/lock.png",
//                               height: MediaQuery.of(context).size.height * 0.2,
//                               width: MediaQuery.of(context).size.width * 0.2,
//                             ),
//                             Text(
//                               'Şifreni Sıfırla',
//                               style: TextStyle(
//                                 fontSize:
//                                     MediaQuery.of(context).size.height / 25,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             _buildEmailRow(),
//                             _buildSifiraButton()
//                           ],
//                         ),
//                       ),
//                     ),
//                   )

//                   // Padding(
//                   //   padding: const EdgeInsets.all(20.0),
//                   //   child: Form(
//                   //       key: _formAnahtari,
//                   //       child: Column(
//                   //         children: <Widget>[
//                   //           TextFormField(
//                   //             keyboardType: TextInputType.emailAddress,
//                   //             decoration: InputDecoration(
//                   //               hintText: "Email adresinizi girin",
//                   //               labelText: "Mail:",
//                   //               errorStyle: TextStyle(fontSize: 16.0),
//                   //               prefixIcon: Icon(Icons.mail),
//                   //             ),
//                   //             validator: (girilenDeger) {
//                   //               if (girilenDeger.isEmpty) {
//                   //                 return "Email alanı boş bırakılamaz!";
//                   //               } else if (!girilenDeger.contains("@")) {
//                   //                 return "Girilen değer mail formatında olmalı!";
//                   //               }
//                   //               return null;
//                   //             },
//                   //             onSaved: (girilenDeger) => email = girilenDeger,
//                   //           ),
//                   //           SizedBox(
//                   //             height: 50.0,
//                   //           ),
//                   //           Container(
//                   //             width: double.infinity,
//                   //             child: FlatButton(
//                   //               onPressed: _sifreyiSifirla,
//                   //               child: Text(
//                   //                 "Şifremi Sıfırla",
//                   //                 style: TextStyle(
//                   //                   fontSize: 20,
//                   //                   fontWeight: FontWeight.bold,
//                   //                 ),
//                   //               ),
//                   //               color: Theme.of(context).primaryColor,
//                   //               textColor: Colors.white,
//                   //             ),
//                   //           ),
//                   //         ],
//                   //       )),
//                   //),
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }

//   Widget _buildEmailRow() {
//     return Padding(
//       padding: EdgeInsets.all(8),
//       child: TextFormField(
//         cursorColor: MelihColors().red,
//         style: TextStyle(color: Colors.white),
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
//         keyboardType: TextInputType.emailAddress,
//         decoration: InputDecoration(
//             labelStyle: TextStyle(color: Colors.white),
//             prefixIcon: Icon(
//               Icons.email,
//               color: MelihColors().red,
//             ),
//             labelText: 'E-mail'),
//       ),
//     );
//   }

//   Widget _buildSifiraButton() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Container(
//           height: 1.4 * (MediaQuery.of(context).size.height / 20),
//           width: 5 * (MediaQuery.of(context).size.width / 10),
//           margin: EdgeInsets.only(bottom: 5),
//           child: RaisedButton(
//             elevation: 5.0,
//             color: MelihColors().red,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30.0),
//             ),
//             onPressed: _sifreyiSifirla,
//             child: Text(
//               "Sıfırla",
//               style: TextStyle(
//                 color: MelihColors().koyuGri,
//                 letterSpacing: 1.5,
//                 fontSize: MediaQuery.of(context).size.height / 40,
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   void _sifreyiSifirla() async {
//     final _yetkilendirmeServisi =
//         Provider.of<YetkilendirmeServisi>(context, listen: false);

//     var _formState = _formAnahtari.currentState;

//     if (_formState.validate()) {
//       _formState.save();
//       setState(() {
//         yukleniyor = true;
//       });

//       try {
//         await _yetkilendirmeServisi.sifremiSifirla(email);
//         setState(() {
//           yukleniyor = false;
//         });
//         showAlertDialog(context);
//       } catch (hata) {
//         setState(() {
//           yukleniyor = false;
//         });
//         uyariGoster(hataKodu: hata.code);
//       }
//     }
//   }

//   showAlertDialog(BuildContext context) {
//     //button
//     Widget okButton = FlatButton(
//       child: Text("Tamam"),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       elevation: 5,
//       backgroundColor: MelihColors().acikGri,
//       title: Text(
//         "İşlem tamam",
//         style: TextStyle(color: Colors.white, fontSize: 20),
//       ),
//       content: Text(
//         "E-mailine parola sıfırlama linki gönderdik.",
//         style: TextStyle(color: Colors.white, fontSize: 20),
//       ),
//       actions: [
//         okButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   uyariGoster({hataKodu}) {
//     String hataMesaji;

//     if (hataKodu == "ERROR_INVALID_EMAIL") {
//       hataMesaji = "Girdiğiniz mail adresi geçersizdir";
//     } else if (hataKodu == "ERROR_USER_NOT_FOUND") {
//       hataMesaji = "Bu mailde bir kullanıcı bulunmuyor";
//     }

//     var snackBar = SnackBar(content: Text(hataMesaji));
//     _scaffoldAnahtari.currentState.showSnackBar(snackBar);
//   }
// }
