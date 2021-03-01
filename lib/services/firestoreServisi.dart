import 'dart:math';

import 'package:uludag_social/models/gonderiler.dart';
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

  // Bu fonksiyonu yazdığımda ne iş yaptığını tanrı
  // ve ben biliyorduk.
  // Şimdi sadece tanrı biliyor.

  Future<List<EvArkadasiGonderi>> evArkadasiGonderileriGetir(
      kullaniciId) async {
    QuerySnapshot snapshot = await _firestore
        .collection("evArkadasiGonderi")
        .doc(kullaniciId)
        .collection("kullaniciGonderileri")
        .orderBy("olusturulmaZamani", descending: true)
        .get();
    List<EvArkadasiGonderi> gonderiler = snapshot.docs
        .map((doc) => EvArkadasiGonderi.dokumandanUret(doc))
        .toList();
    return gonderiler;
  }

  Future<List<NotGonderi>> notGonderileriGetir(kullaniciId) async {
    QuerySnapshot snapshot = await _firestore
        .collection("notGonderi")
        .doc(kullaniciId)
        .collection("kullaniciGonderileri")
        .orderBy("olusturulmaZamani", descending: true)
        .get();
    List<NotGonderi> gonderiler =
        snapshot.docs.map((doc) => NotGonderi.dokumandanUret(doc)).toList();
    return gonderiler;
  }

  Future<List<YolculukGonderi>> yolculukGonderileriGetir(kullaniciId) async {
    QuerySnapshot snapshot = await _firestore
        .collection("yolculukGonderi")
        .doc(kullaniciId)
        .collection("kullaniciGonderileri")
        .orderBy("olusturulmaZamani", descending: true)
        .get();
    List<YolculukGonderi> gonderiler = snapshot.docs
        .map((doc) => YolculukGonderi.dokumandanUret(doc))
        .toList();
    return gonderiler;
  }

  Future<List<EsyaGonderi>> esyaGonderileriGetir(kullaniciId) async {
    QuerySnapshot snapshot = await _firestore
        .collection("esyaGonderi")
        .doc(kullaniciId)
        .collection("kullaniciGonderileri")
        .orderBy("olusturulmaZamani", descending: true)
        .get();
    List<EsyaGonderi> gonderiler =
        snapshot.docs.map((doc) => EsyaGonderi.dokumandanUret(doc)).toList();
    return gonderiler;
  }

  Future<void> evArkadasiGonderiBegen(
      EvArkadasiGonderi gonderi, String aktifKullaniciId) async {
    DocumentSnapshot doc = await _firestore
        .collection("evArkadasiGonderi")
        .doc(gonderi.yayinlayanId)
        .collection("kullaniciGonderileri")
        .doc(gonderi.id)
        .get();
    if (doc.exists) {
      EvArkadasiGonderi gonderi = EvArkadasiGonderi.dokumandanUret(doc);
      int yeniBegeniSayisi = gonderi.begeniSayisi + 1;
      _firestore
          .collection("evArkadasiGonderi")
          .doc(gonderi.yayinlayanId)
          .collection("kullaniciGonderileri")
          .doc(gonderi.id)
          .update({"begeniSayisi": yeniBegeniSayisi});
      _firestore
          .collection("begeniler")
          .doc("evArkadasi")
          .collection("gonderiId")
          .doc(gonderi.id)
          .collection("gonderiyiBegenenler")
          .doc(aktifKullaniciId)
          .set({});
    }
  }

  Future<void> evArkadasiGonderiBegeniKaldir(
      EvArkadasiGonderi gonderi, String aktifKullaniciId) async {
    DocumentSnapshot doc = await _firestore
        .collection("evArkadasiGonderi")
        .doc(gonderi.yayinlayanId)
        .collection("kullaniciGonderileri")
        .doc(gonderi.id)
        .get();
    if (doc.exists) {
      EvArkadasiGonderi gonderi = EvArkadasiGonderi.dokumandanUret(doc);
      int yeniBegeniSayisi = gonderi.begeniSayisi - 1;
      _firestore
          .collection("evArkadasiGonderi")
          .doc(gonderi.yayinlayanId)
          .collection("kullaniciGonderileri")
          .doc(gonderi.id)
          .update({"begeniSayisi": yeniBegeniSayisi});
      DocumentSnapshot docBegeni = await _firestore
          .collection("begeniler")
          .doc("evArkadasi")
          .collection("gonderiId")
          .doc(gonderi.id)
          .collection("gonderiyiBegenenler")
          .doc(aktifKullaniciId)
          .get();
      if (docBegeni.exists) {
        docBegeni.reference.delete();
      }
    }
  }

  Future<bool> evArkadasiBegeniVarMi(
      EvArkadasiGonderi gonderi, String aktifKullaniciId) async {
    DocumentSnapshot docBegeni = await _firestore
        .collection("begeniler")
        .doc("evArkadasi")
        .collection("gonderiId")
        .doc(gonderi.id)
        .collection("gonderiyiBegenenler")
        .doc(aktifKullaniciId)
        .get();

    if (docBegeni.exists) {
      return true;
    }

    return false;
  }

  Future<void> yolculukGonderiBegen(
      YolculukGonderi gonderi, String aktifKullaniciId) async {
    DocumentSnapshot doc = await _firestore
        .collection("yolculukGonderi")
        .doc(gonderi.yayinlayanId)
        .collection("kullaniciGonderileri")
        .doc(gonderi.id)
        .get();
    if (doc.exists) {
      YolculukGonderi gonderi = YolculukGonderi.dokumandanUret(doc);
      int yeniBegeniSayisi = gonderi.begeniSayisi + 1;
      _firestore
          .collection("yolculukGonderi")
          .doc(gonderi.yayinlayanId)
          .collection("kullaniciGonderileri")
          .doc(gonderi.id)
          .update({"begeniSayisi": yeniBegeniSayisi});
      _firestore
          .collection("begeniler")
          .doc("yolculuk")
          .collection("gonderiId")
          .doc(gonderi.id)
          .collection("gonderiyiBegenenler")
          .doc(aktifKullaniciId)
          .set({});
    }
  }

  Future<void> yolculukGonderiBegeniKaldir(
      YolculukGonderi gonderi, String aktifKullaniciId) async {
    DocumentSnapshot doc = await _firestore
        .collection("yolculukGonderi")
        .doc(gonderi.yayinlayanId)
        .collection("kullaniciGonderileri")
        .doc(gonderi.id)
        .get();
    if (doc.exists) {
      YolculukGonderi gonderi = YolculukGonderi.dokumandanUret(doc);
      int yeniBegeniSayisi = gonderi.begeniSayisi - 1;
      _firestore
          .collection("yolculukGonderi")
          .doc(gonderi.yayinlayanId)
          .collection("kullaniciGonderileri")
          .doc(gonderi.id)
          .update({"begeniSayisi": yeniBegeniSayisi});
      DocumentSnapshot docBegeni = await _firestore
          .collection("begeniler")
          .doc("yolculuk")
          .collection("gonderiId")
          .doc(gonderi.id)
          .collection("gonderiyiBegenenler")
          .doc(aktifKullaniciId)
          .get();
      if (docBegeni.exists) {
        docBegeni.reference.delete();
      }
    }
  }

  Future<bool> yolculukBegeniVarMi(
      YolculukGonderi gonderi, String aktifKullaniciId) async {
    DocumentSnapshot docBegeni = await _firestore
        .collection("begeniler")
        .doc("yolculuk")
        .collection("gonderiId")
        .doc(gonderi.id)
        .collection("gonderiyiBegenenler")
        .doc(aktifKullaniciId)
        .get();

    if (docBegeni.exists) {
      return true;
    }

    return false;
  }

  Future<void> esyaGonderiBegen(
      EsyaGonderi gonderi, String aktifKullaniciId) async {
    DocumentSnapshot doc = await _firestore
        .collection("esyaGonderi")
        .doc(gonderi.yayinlayanId)
        .collection("kullaniciGonderileri")
        .doc(gonderi.id)
        .get();
    if (doc.exists) {
      EsyaGonderi gonderi = EsyaGonderi.dokumandanUret(doc);
      int yeniBegeniSayisi = gonderi.begeniSayisi + 1;
      _firestore
          .collection("esyaGonderi")
          .doc(gonderi.yayinlayanId)
          .collection("kullaniciGonderileri")
          .doc(gonderi.id)
          .update({"begeniSayisi": yeniBegeniSayisi});
      _firestore
          .collection("begeniler")
          .doc("esya")
          .collection("gonderiId")
          .doc(gonderi.id)
          .collection("gonderiyiBegenenler")
          .doc(aktifKullaniciId)
          .set({});
    }
  }

  Future<void> esyaGonderiBegeniKaldir(
      EsyaGonderi gonderi, String aktifKullaniciId) async {
    DocumentSnapshot doc = await _firestore
        .collection("esyaGonderi")
        .doc(gonderi.yayinlayanId)
        .collection("kullaniciGonderileri")
        .doc(gonderi.id)
        .get();
    if (doc.exists) {
      EsyaGonderi gonderi = EsyaGonderi.dokumandanUret(doc);
      int yeniBegeniSayisi = gonderi.begeniSayisi - 1;
      _firestore
          .collection("esyaGonderi")
          .doc(gonderi.yayinlayanId)
          .collection("kullaniciGonderileri")
          .doc(gonderi.id)
          .update({"begeniSayisi": yeniBegeniSayisi});
      DocumentSnapshot docBegeni = await _firestore
          .collection("begeniler")
          .doc("esya")
          .collection("gonderiId")
          .doc(gonderi.id)
          .collection("gonderiyiBegenenler")
          .doc(aktifKullaniciId)
          .get();
      if (docBegeni.exists) {
        docBegeni.reference.delete();
      }
    }
  }

  Future<bool> esyaBegeniVarMi(
      EsyaGonderi gonderi, String aktifKullaniciId) async {
    DocumentSnapshot docBegeni = await _firestore
        .collection("begeniler")
        .doc("esya")
        .collection("gonderiId")
        .doc(gonderi.id)
        .collection("gonderiyiBegenenler")
        .doc(aktifKullaniciId)
        .get();

    if (docBegeni.exists) {
      return true;
    }

    return false;
  }

  Future<void> notGonderiBegen(
      NotGonderi gonderi, String aktifKullaniciId) async {
    DocumentSnapshot doc = await _firestore
        .collection("notGonderi")
        .doc(gonderi.yayinlayanId)
        .collection("kullaniciGonderileri")
        .doc(gonderi.id)
        .get();
    if (doc.exists) {
      NotGonderi gonderi = NotGonderi.dokumandanUret(doc);
      int yeniBegeniSayisi = gonderi.begeniSayisi + 1;
      _firestore
          .collection("notGonderi")
          .doc(gonderi.yayinlayanId)
          .collection("kullaniciGonderileri")
          .doc(gonderi.id)
          .update({"begeniSayisi": yeniBegeniSayisi});
      _firestore
          .collection("begeniler")
          .doc("not")
          .collection("gonderiId")
          .doc(gonderi.id)
          .collection("gonderiyiBegenenler")
          .doc(aktifKullaniciId)
          .set({});
    }
  }

  Future<void> notGonderiBegeniKaldir(
      NotGonderi gonderi, String aktifKullaniciId) async {
    DocumentSnapshot doc = await _firestore
        .collection("notGonderi")
        .doc(gonderi.yayinlayanId)
        .collection("kullaniciGonderileri")
        .doc(gonderi.id)
        .get();
    if (doc.exists) {
      NotGonderi gonderi = NotGonderi.dokumandanUret(doc);
      int yeniBegeniSayisi = gonderi.begeniSayisi - 1;
      _firestore
          .collection("notGonderi")
          .doc(gonderi.yayinlayanId)
          .collection("kullaniciGonderileri")
          .doc(gonderi.id)
          .update({"begeniSayisi": yeniBegeniSayisi});
      DocumentSnapshot docBegeni = await _firestore
          .collection("begeniler")
          .doc("not")
          .collection("gonderiId")
          .doc(gonderi.id)
          .collection("gonderiyiBegenenler")
          .doc(aktifKullaniciId)
          .get();
      if (docBegeni.exists) {
        docBegeni.reference.delete();
      }
    }
  }

  Future<bool> notBegeniVarMi(
      NotGonderi gonderi, String aktifKullaniciId) async {
    DocumentSnapshot docBegeni = await _firestore
        .collection("begeniler")
        .doc("not")
        .collection("gonderiId")
        .doc(gonderi.id)
        .collection("gonderiyiBegenenler")
        .doc(aktifKullaniciId)
        .get();

    if (docBegeni.exists) {
      return true;
    }

    return false;
  }

  Future<List<Kullanici>> kullaniciAra(String kelime) async {
    QuerySnapshot snapshot = await _firestore
        .collection("kullanicilar")
        .where("kullaniciAdi", isGreaterThanOrEqualTo: kelime)
        .get();

    List<Kullanici> kullanicilar =
        snapshot.docs.map((doc) => Kullanici.dokumandanUret(doc)).toList();
    return kullanicilar;
  }
}
