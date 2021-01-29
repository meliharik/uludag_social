import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';
import 'package:uludag_social/pages/akis.dart';
import 'package:uludag_social/pages/ara.dart';
import 'package:uludag_social/pages/duyurular.dart';
import 'package:uludag_social/pages/profil.dart';
import 'package:uludag_social/pages/yukle.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _aktifSayfaNo = 0;
  PageController sayfaKumandasi;

  @override
  void initState() {
    super.initState();
    sayfaKumandasi = PageController();
  }

  @override
  void dispose() {
    sayfaKumandasi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String aktifKullaniciId =
        Provider.of<YetkilendirmeServisi>(context, listen: false)
            .aktifKullaniciId;
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (acilanSayfaNo) {
          setState(() {
            _aktifSayfaNo = acilanSayfaNo;
          });
        },
        controller: sayfaKumandasi,
        children: [
          Akis(),
          Ara(),
          Yukle(),
          Duyurlar(),
          Profil(
            profilSahibiId: aktifKullaniciId,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: MelihColors().koyuGri,
        currentIndex: _aktifSayfaNo,
        selectedItemColor: MelihColors().main,
        unselectedItemColor: MelihColors().white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Ara'),
          BottomNavigationBarItem(
              icon: Icon(Icons.file_upload), label: 'Yükle'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Duyurular'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        onTap: (secilenSayfaNo) {
          setState(() {
            sayfaKumandasi.jumpToPage(secilenSayfaNo);
          });
        },
      ),
    );
  }
}
