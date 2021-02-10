import 'package:cloud_firestore/cloud_firestore.dart';

class YolculukGonderi {
  final String id;
  final String baslik;
  final String aciklama;
  final String yayinlayanId;
  final int begeniSayisi;
  final String konumNereden;
  final String konumNereye;
  final String tarih;
  final String saat;

  YolculukGonderi({
    this.id,
    this.aciklama,
    this.yayinlayanId,
    this.begeniSayisi,
    this.konumNereden,
    this.konumNereye,
    this.tarih,
    this.saat,
    this.baslik,
  });

  factory YolculukGonderi.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc.data();
    return YolculukGonderi(
      id: doc.id,
      yayinlayanId: docData['yayinlayanId'],
      begeniSayisi: docData['begeniSayisi'],
      baslik: docData['baslik'],
      aciklama: docData['aciklama'],
      konumNereden: docData['nereden'],
      konumNereye: docData['nereye'],
      saat: docData['saat'],
      tarih: docData['tarih'],
    );
  }
}

class EsyaGonderi {
  final String id;
  final String baslik;
  final String aciklama;
  final String gonderiResmiUrl;
  final String fiyat;
  final String yayinlayanId;
  final int begeniSayisi;
  final String konum;
  final String kategori;

  EsyaGonderi(
      {this.id,
      this.baslik,
      this.aciklama,
      this.gonderiResmiUrl,
      this.fiyat,
      this.konum,
      this.yayinlayanId,
      this.begeniSayisi,
      this.kategori});

  factory EsyaGonderi.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc.data();
    return EsyaGonderi(
      id: doc.id,
      yayinlayanId: docData['yayinlayanId'],
      begeniSayisi: docData['begeniSayisi'],
      baslik: docData['baslik'],
      aciklama: docData['aciklama'],
      konum: docData['konum'],
      fiyat: docData['fiyat'],
      gonderiResmiUrl: docData['gonderiResmiUrl'],
      kategori: docData['kategori'],
    );
  }
}

class EvArkadasiGonderi {
  final String id;
  final String baslik;
  final String aciklama;
  final String gonderiResmiUrl;
  final String kira;
  final String yayinlayanId;
  final int begeniSayisi;
  final String konum;
  final String odaSayisi;

  EvArkadasiGonderi(
      {this.id,
      this.aciklama,
      this.gonderiResmiUrl,
      this.kira,
      this.konum,
      this.yayinlayanId,
      this.begeniSayisi,
      this.odaSayisi,
      this.baslik});

  factory EvArkadasiGonderi.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc.data();
    return EvArkadasiGonderi(
      id: doc.id,
      yayinlayanId: docData['yayinlayanId'],
      begeniSayisi: docData['begeniSayisi'],
      baslik: docData['baslik'],
      aciklama: docData['aciklama'],
      konum: docData['konum'],
      kira: docData['kira'],
      gonderiResmiUrl: docData['gonderiResmiUrl'],
      odaSayisi: docData['odaSayisi'],
    );
  }
}

class NotGonderi {
  final String id;
  final String baslik;
  final String aciklama;
  final String yayinlayanId;
  final int begeniSayisi;
  final String bolum;
  final String ders;
  final String dersinHocasi;
  final String sayfaSayisi;
  final String fiyat;

  NotGonderi(
      {this.id,
      this.aciklama,
      this.yayinlayanId,
      this.begeniSayisi,
      this.bolum,
      this.ders,
      this.dersinHocasi,
      this.sayfaSayisi,
      this.fiyat,
      this.baslik});

  factory NotGonderi.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc.data();
    return NotGonderi(
      id: doc.id,
      yayinlayanId: docData['yayinlayanId'],
      begeniSayisi: docData['begeniSayisi'],
      baslik: docData['baslik'],
      aciklama: docData['aciklama'],
      bolum: docData['bolum'],
      ders: docData['ders'],
      sayfaSayisi: docData['sayfaSayisi'],
      dersinHocasi: docData['dersinHocasi'],
      fiyat: docData['fiyat'],
    );
  }
}
