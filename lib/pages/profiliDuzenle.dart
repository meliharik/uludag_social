import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';
import 'package:uludag_social/models/kullanici.dart';
import 'package:uludag_social/services/firestoreServisi.dart';
import 'package:uludag_social/services/storageServisi.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';

class ProfiliDuzenle extends StatefulWidget {
  final Kullanici profil;

  const ProfiliDuzenle({Key key, this.profil}) : super(key: key);
  @override
  _ProfiliDuzenleState createState() => _ProfiliDuzenleState();
}

class _ProfiliDuzenleState extends State<ProfiliDuzenle> {
  var _formKey = GlobalKey<FormState>();

  String _kullaniciAdi, _hakkinda, _email;
  File _secilmisFoto;
  bool _yukleniyor = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MelihColors().koyuGri,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: MelihColors().koyuGri,
        title: Text(
          'Profili Düzenle',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: _kaydet,
            icon: Icon(
              Icons.check,
              size: 30,
              color: MelihColors().main,
            ),
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.close_outlined, size: 30, color: MelihColors().red),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          _yukleniyor
              ? LinearProgressIndicator()
              : SizedBox(
                  height: 0.0,
                ),
          _profilFoto(),
          _changePPText(),
          _kullaniciBilgileri(),
        ],
      ),
    );
  }

  _kaydet() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _yukleniyor = true;
      });

      _formKey.currentState.save();

      String profilFotoUrl;
      if (_secilmisFoto == null) {
        profilFotoUrl = widget.profil.fotoUrl;
      } else {
        profilFotoUrl = await StorageServisi().profilResmiYukle(_secilmisFoto);
      }

      String aktifKullaniciId =
          Provider.of<YetkilendirmeServisi>(context, listen: false)
              .aktifKullaniciId;

      FirestoreServisi().kullaniciGuncelle(
          kullaniciId: aktifKullaniciId,
          kullaniciAdi: _kullaniciAdi,
          hakkinda: _hakkinda,
          fotoUrl: profilFotoUrl);

      setState(() {
        _yukleniyor = false;
      });

      Navigator.pop(context);
    }
  }

  _profilFoto() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 20),
      child: Center(
        child: InkWell(
          onTap: _galeridenSec,
          child: CircleAvatar(
              backgroundColor: MelihColors().acikacikGri,
              radius: 65,
              backgroundImage: _secilmisFoto == null
                  ? NetworkImage(widget.profil.fotoUrl)
                  : FileImage(_secilmisFoto)),
        ),
      ),
    );
  }

  _changePPText() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: InkWell(
          onTap: _galeridenSec,
          child: Text(
            'Profil Fotoğrafını Değiştir',
            style: TextStyle(
                color: MelihColors().main,
                fontSize: MediaQuery.of(context).size.height / 45),
          ),
        ),
      ),
    );
  }

  _galeridenSec() async {
    var image = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 80);
    setState(() {
      _secilmisFoto = File(image.path);
    });
  }

  // _fotoBelirleme() {
  //   return widget.profil.fotoUrl == null || widget.profil.fotoUrl == ''
  //       ? SvgPicture.network(
  //           "https://avatars.dicebear.com/api/bottts/" +
  //               widget.profil.kullaniciAdi +
  //               ".svg?background=%23202124",
  //         )
  //       : NetworkImage(widget.profil.fotoUrl); // Image.network(userImage),
  // }

  _kullaniciBilgileri() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 20),
            // TextFormField(
            //   initialValue: widget.profil.kullaniciAdi,
            //   onSaved: (girilenDeger) {
            //     _kullaniciAdi = girilenDeger;
            //   },
            //   validator: (girilenDeger) {
            //     return girilenDeger.trim().length <= 3
            //         ? "Kullanıcı adı en az 4 karakter olmalı"
            //         : null;
            //   },
            //   decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
            // ),
            // TextFormField(
            //   initialValue: widget.profil.hakkinda,
            //   onSaved: (girilenDeger) {
            //     _hakkinda = girilenDeger;
            //   },
            //   validator: (girilenDeger) {
            //     return girilenDeger.trim().length >= 100
            //         ? "Maksimum 100 karakter"
            //         : null;
            //   },
            //   decoration: InputDecoration(labelText: 'Hakkında'),
            // ),
            _buildKullaniciAdi(),
            _buildHakkinda(),
            _buildEmail()
          ],
        ),
      ),
    );
  }

  Widget _buildKullaniciAdi() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        initialValue: widget.profil.kullaniciAdi,
        style: TextStyle(color: Colors.white),
        validator: (girilenDeger) {
          return girilenDeger.trim().length <= 3
              ? "Kullanıcı Adı en az 4 karakter olmalı"
              : null;
        },
        onSaved: (girilenDeger) {
          _kullaniciAdi = girilenDeger;
        },
        decoration: InputDecoration(
            labelStyle: TextStyle(color: MelihColors().white),
            labelText: 'Kullanıcı Adı'),
      ),
    );
  }

  Widget _buildHakkinda() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        initialValue: widget.profil.hakkinda,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.text,
        onSaved: (girilenDeger) {
          _hakkinda = girilenDeger;
        },
        validator: (girilenDeger) {
          return girilenDeger.trim().length >= 100
              ? "Maksimum 100 karakter"
              : null;
        },
        decoration: InputDecoration(
            labelStyle: TextStyle(color: MelihColors().white),
            labelText: 'Hakkında'),
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          showAlertDialog(context);
        },
        child: TextFormField(
          enabled: false,
          initialValue: widget.profil.email,
          style: TextStyle(color: MelihColors().main),
          validator: (girilenDeger) {
            return girilenDeger.trim().length <= 3
                ? "Kullanıcı Adı en az 4 karakter olmalı"
                : null;
          },
          onSaved: (girilenDeger) {
            _kullaniciAdi = girilenDeger;
          },
          decoration: InputDecoration(
              labelStyle: TextStyle(color: MelihColors().white),
              labelText: 'Kullanıcı Adı'),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Tamam", style: TextStyle(color: MelihColors().main)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      elevation: 5,
      backgroundColor: MelihColors().acikGri,
      title: Text(
        "Hoop",
        style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      content: Text(
          "Mail değiştirme işlemi şu anlık geçerli değil.\nEn kısa zamanda ekleyeceğiz.",
          style: TextStyle(color: Colors.white, fontSize: 17)),
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
}
