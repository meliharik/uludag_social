import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';
import 'package:uludag_social/models/kullanici.dart';
import 'package:uludag_social/services/firestoreServisi.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';

class Ilanlar extends StatefulWidget {
  final String profilSahibiId;

  const Ilanlar({Key key, this.profilSahibiId}) : super(key: key);
  @override
  _IlanlarState createState() => _IlanlarState();
}

class _IlanlarState extends State<Ilanlar> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MelihColors().main,
          actions: [
            IconButton(
                icon: Transform.rotate(
                  angle: 5.8,
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  print('mesajlaşma sayfasına geçecek');
                }),
          ],
        ),
        backgroundColor: MelihColors().acikGri,
        body: Stack(
          children: [
            Container(
              height: _height * 0.45,
              width: _width,
              child: ClipPath(
                clipper: ClippingClass(),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 4 / 7,
                  decoration: BoxDecoration(color: MelihColors().main),
                ),
              ),
            ),
            FutureBuilder<Object>(
                future:
                    FirestoreServisi().kullaniciGetir(widget.profilSahibiId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children: [
                      _elemanlar(snapshot.data),
                    ],
                  );
                }),
          ],
        ));
  }

  Widget _elemanlar(Kullanici profilData) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Row(
        children: [
          SizedBox(
            width: _width * 0.075,
          ),
          Container(
            width: _width * 0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 70.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(profilData.fotoUrl)),
                      color: MelihColors().main,
                      shape: BoxShape.circle),
                  child: profilData.fotoUrl.isEmpty
                      ? SvgPicture.network(
                          "https://avatars.dicebear.com/api/bottts/" +
                              profilData.kullaniciAdi +
                              ".svg?background=%237289da",
                        )
                      : null, // Image.network(userImage),
                ),
                // CircleAvatar(
                //   radius: MediaQuery.of(context).size.height * 0.05,
                //   backgroundColor: MelihColors().koyuGri,
                //   child: profilData.fotoUrl.isEmpty
                //       ? SvgPicture.network(
                //           "https://avatars.dicebear.com/api/bottts/" +
                //               profilData.kullaniciAdi +
                //               ".svg?background=%232f3136",
                //         )
                //       : Image.network(profilData.fotoUrl),
                // ),
                SizedBox(
                  height: _height * 0.015,
                ),
                Text(
                  'Selam ${profilData.kullaniciAdi}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height / 25,
                  ),
                ),
                SizedBox(
                  height: _height * 0.015,
                ),
                Text(
                  'Seni bekleyen bir sürü ilana hemen göz at.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.normal,
                    fontSize: MediaQuery.of(context).size.height / 35,
                  ),
                ),
                SizedBox(
                  height: _height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => print("İlan 1"),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: _width * 0.4,
                            height: _height * 0.2,
                            color: MelihColors().acikacikGri,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Image.asset(
                                  "assets/images/success.png",
                                  width: _width * 0.15,
                                )),
                                SizedBox(
                                  height: _height * 0.02,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: _width * 0.025,
                                    ),
                                    Text(
                                      'Ev Arkadaşı İlanları',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: _height / 40),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: _height * 0.006,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: _width * 0.025,
                                    ),
                                    Text(
                                      'İlan Sayısı 1',
                                      style: TextStyle(
                                          color: MelihColors().white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: _height / 45),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () => print("İlan 2"),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: _width * 0.4,
                            height: _height * 0.2,
                            color: MelihColors().acikacikGri,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Image.asset(
                                  "assets/images/success.png",
                                  width: _width * 0.15,
                                )),
                                SizedBox(
                                  height: _height * 0.02,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: _width * 0.025,
                                    ),
                                    Text(
                                      'Sıfır / İkinci El\nEşya İlanları',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: _height / 45),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: _height * 0.006,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: _width * 0.025,
                                    ),
                                    Text(
                                      'İlan Sayısı 2',
                                      style: TextStyle(
                                          color: MelihColors().white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: _height / 45),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => print("İlan 3"),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: _width * 0.4,
                            height: _height * 0.2,
                            color: MelihColors().acikacikGri,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Image.asset(
                                  "assets/images/success.png",
                                  width: _width * 0.15,
                                )),
                                SizedBox(
                                  height: _height * 0.02,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: _width * 0.025,
                                    ),
                                    Text(
                                      'Yolculuk İlanları',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: _height / 40),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: _height * 0.006,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: _width * 0.025,
                                    ),
                                    Text(
                                      'İlan Sayısı 3',
                                      style: TextStyle(
                                          color: MelihColors().white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: _height / 45),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () => print("İlan 4"),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: _width * 0.4,
                            height: _height * 0.2,
                            color: MelihColors().acikacikGri,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Image.asset(
                                  "assets/images/success.png",
                                  width: _width * 0.15,
                                )),
                                SizedBox(
                                  height: _height * 0.02,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: _width * 0.025,
                                    ),
                                    Text(
                                      'Not İlanları',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: _height / 35),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: _height * 0.006,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: _width * 0.025,
                                    ),
                                    Text(
                                      'İlan Sayısı 4',
                                      style: TextStyle(
                                          color: MelihColors().white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: _height / 45),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: _width * 0.075,
          )
        ],
      ),
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    var controlPoint = Offset(size.width - (size.width / 2), size.height - 120);
    var endPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
