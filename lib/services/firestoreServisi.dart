import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uludag_social/models/kullanici.dart';

class FirestoreServisi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DateTime zaman = DateTime.now();

  Future<void> kullaniciOlustur({id, email, kullaniciAdi, fotoUrl = ""}) async {
    await _firestore.collection("kullanicilar").doc(id).set({
      "kullaniciAdi": kullaniciAdi,
      "email": email,
      "fotoUrl": fotoUrl,
      "hakkinda": "",
      "olusturulmaZamani": zaman
    });
  }

  Future<Kullanici> kullaniciGetir(id) async {
    DocumentSnapshot doc =
        await _firestore.collection("kullanicilar").doc(id).get();
    if (doc.exists) {
      Kullanici kullanici = Kullanici.dokumandanUret(doc);
      return kullanici;
    }
    return null;
  }

  void kullaniciGuncelle(
      {String kullaniciId,
      String kullaniciAdi,
      String fotoUrl = "",
      String hakkinda}) {
    _firestore.collection("kullanicilar").doc(kullaniciId).update({
      "kullaniciAdi": kullaniciAdi,
      "hakkinda": hakkinda,
      "fotoUrl": fotoUrl
    });
  }

  Future<int> takipciSayisi(kullaniciId) async {
    QuerySnapshot snapshot = await _firestore
        .collection("takipciler")
        .doc(kullaniciId)
        .collection("kullanicininTakipcileri")
        .get();
    return snapshot.docs.length;
  }

  Future<int> takipEdilenSayisi(kullaniciId) async {
    QuerySnapshot snapshot = await _firestore
        .collection("takipEdilenler")
        .doc(kullaniciId)
        .collection("kullanicininTakipleri")
        .get();
    return snapshot.docs.length;
  }

  // Future<int> yolculukGonderiSayisi() async {
  //   QuerySnapshot snapshot =
  //       await _firestore.collection("yolculukGonderi").get();
  //   return snapshot.docs.length;
  // }

  // Future<int> yolculukGonderiSayisi() async {
  //   int toplam = 0;
  //   QuerySnapshot snapshot1 =
  //       await _firestore.collection("yolculukGonderi").get();
  //   QuerySnapshot snapshot2 = await _firestore
  //       .collection("yolculukGonderi")
  //       .doc()
  //       .collection("kullaniciGonderileri")
  //       .get();

  //   for (int i = 0; i < snapshot1.docs.length; i++) {
  //     for (int j = 0; j < snapshot2.docs.length; j++) {
  //       toplam++;
  //     }
  //   }

  //   return toplam;
  // }

  // Future<int> esyaGonderiSayisi() async {
  //   QuerySnapshot snapshot = await _firestore.collection("esyaGonderi").get();
  //   return snapshot.docs.length;
  // }

  // Future<int> notGonderiSayisi() async {
  //   QuerySnapshot snapshot = await _firestore.collection("notGonderi").get();
  //   return snapshot.docs.length;
  // }

  // Future<int> evArkadasiGonderiSayisi() async {
  //   QuerySnapshot snapshot =
  //       await _firestore.collection("evArkadasiGonderi").get();
  //   return snapshot.docs.length;
  // }

  Future<void> evArkadasiGonderiOlustur(
      {gonderiResmiUrl,
      baslik,
      aciklama,
      konum,
      kira,
      odaSayisi,
      yayinlayanId}) async {
    await _firestore
        .collection("evArkadasiGonderi")
        .doc(yayinlayanId)
        .collection("kullaniciGonderileri")
        .add({
      "gonderiResmiUrl": gonderiResmiUrl,
      "baslik": baslik,
      "aciklama": aciklama,
      "odaSayisi": odaSayisi,
      "kira": kira,
      "yayinlayanId": yayinlayanId,
      "begeniSayisi": 0,
      "konum": konum,
      "olusturulmaZamani": zaman
    });
  }

  Future<void> esyaGonderiOlustur(
      {gonderiResmiUrl,
      baslik,
      aciklama,
      konum,
      fiyat,
      kategori,
      yayinlayanId}) async {
    await _firestore
        .collection("esyaGonderi")
        .doc(yayinlayanId)
        .collection("kullaniciGonderileri")
        .add({
      "gonderiResmiUrl": gonderiResmiUrl,
      "baslik": baslik,
      "aciklama": aciklama,
      "kategori": kategori,
      "fiyat": fiyat,
      "yayinlayanId": yayinlayanId,
      "begeniSayisi": 0,
      "konum": konum,
      "olusturulmaZamani": zaman
    });
  }

  Future<void> yolculukGonderiOlustur(
      {tarih, baslik, aciklama, nereye, saat, nereden, yayinlayanId}) async {
    await _firestore
        .collection("yolculukGonderi")
        .doc(yayinlayanId)
        .collection("kullaniciGonderileri")
        .add({
      "tarih": tarih,
      "baslik": baslik,
      "aciklama": aciklama,
      "nereden": nereden,
      "saat": saat,
      "yayinlayanId": yayinlayanId,
      "begeniSayisi": 0,
      "nereye": nereye,
      "olusturulmaZamani": zaman
    });
  }

  Future<void> notGonderiOlustur(
      {bolum,
      baslik,
      aciklama,
      sayfaSayisi,
      dersinHocasi,
      ders,
      yayinlayanId,
      fiyat}) async {
    await _firestore
        .collection("notGonderi")
        .doc(yayinlayanId)
        .collection("kullaniciGonderileri")
        .add({
      "bolum": bolum,
      "baslik": baslik,
      "aciklama": aciklama,
      "ders": ders,
      "dersinHocasi": dersinHocasi,
      "yayinlayanId": yayinlayanId,
      "begeniSayisi": 0,
      "sayfaSayisi": sayfaSayisi,
      "olusturulmaZamani": zaman,
      "fiyat": fiyat
    });
  }
}
