import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/kullanici.dart';
import 'package:uludag_social/pages/anaSayfa.dart';
import 'package:uludag_social/pages/girisSayfasi.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';

class Yonlendirme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _yetkilendirmeServisi =
        Provider.of<YetkilendirmeServisi>(context, listen: false);
    return StreamBuilder(
      stream: _yetkilendirmeServisi.durumTakipcisi,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          Kullanici aktifKullanici = snapshot.data;
          _yetkilendirmeServisi.aktifKullaniciId = aktifKullanici.id;
          return AnaSayfa();
        } else {
          return GirisSayfasi();
        }
      },
    );
  }
}
