import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';
import 'package:uludag_social/models/kullanici.dart';
import 'package:uludag_social/services/firestoreServisi.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';

class Profil extends StatefulWidget {
  final String profilSahibiId;

  const Profil({Key key, this.profilSahibiId}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MelihColors().koyuGri,
        title: Text(
          'Profil',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: _cikisYap)
        ],
      ),
      body: FutureBuilder<Object>(
          future: FirestoreServisi().kullaniciGetir(widget.profilSahibiId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: [
                _profilDetaylari(snapshot.data),
              ],
            );
          }),
      backgroundColor: MelihColors().acikGri,
    );
  }

  Widget _profilDetaylari(Kullanici profilData) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // CircleAvatar(
              //   backgroundImage: profilData.fotoUrl.isEmpty
              //       ? SvgPicture.network(
              //           "https://avatars.dicebear.com/api/gridy/" +
              //               profilData.kullaniciAdi +
              //               ".svg?background=%230000ff",
              //         )
              //       : NetworkImage(profilData.fotoUrl),
              //   backgroundColor: MelihColors().main,
              //   radius: 50,
              // ),
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                    color: MelihColors().acikGri, shape: BoxShape.circle),
                child: profilData.fotoUrl == null || profilData.fotoUrl == ''
                    ? SvgPicture.network(
                        "https://avatars.dicebear.com/api/bottts/" +
                            profilData.fotoUrl +
                            ".svg?background=%232f3136",
                      )
                    : CachedNetworkImage(
                        imageUrl: profilData.fotoUrl,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                      ), // Image.network(userImage),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _sosyalSayac(baslik: "Gönderiler", sayi: 32),
                    _sosyalSayac(baslik: "Takipçi", sayi: 687),
                    _sosyalSayac(baslik: "Takip", sayi: 567),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(profilData.kullaniciAdi,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          SizedBox(
            height: 5,
          ),
          Text(
            profilData.hakkinda,
            style: TextStyle(
              fontSize: 15,
              color: MelihColors().white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _profiliDuzenleButon(),
        ],
      ),
    );
  }

  Widget _profiliDuzenleButon() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {
            print('Selamın Aleyk');
          },
          child: Text(
            'Profili Düzenle',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          )),
    );
  }

  Widget _sosyalSayac({String baslik, int sayi}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          sayi.toString(),
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          baslik,
          style: TextStyle(fontSize: 15, color: MelihColors().white),
        ),
      ],
    );
  }

  void _cikisYap() {
    Provider.of<YetkilendirmeServisi>(context, listen: false).cikisYap();
  }
}
