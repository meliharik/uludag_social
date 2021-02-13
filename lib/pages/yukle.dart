import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';
import 'package:uludag_social/models/gonderiler.dart';
import 'package:uludag_social/pages/esyaIlanEkle.dart';
import 'package:uludag_social/pages/evArkadasiIlanEkle.dart';
import 'package:uludag_social/pages/notIlanEkle.dart';
import 'package:uludag_social/pages/yolculukIlanEkle.dart';
import 'package:uludag_social/services/firestoreServisi.dart';

class Yukle extends StatefulWidget {
  @override
  _YukleState createState() => _YukleState();
}

class _YukleState extends State<Yukle> {
  // int _yolculukGonderiSayisi = 0;
  // int _notGonderiSayisi = 0;
  // int _esyaGonderiSayisi = 0;
  // int _evArkadasiGonderiSayisi = 0;

  // _yolculukGonderiSayisiGetir() async {
  //   int yolculukGonderiSayisi =
  //       await FirestoreServisi().yolculukGonderiSayisi();
  //   if (mounted) {
  //     setState(() {
  //       _yolculukGonderiSayisi = yolculukGonderiSayisi;
  //     });
  //   }
  // }

  // _notGonderiSayisiGetir() async {
  //   int notGonderiSayisi = await FirestoreServisi().notGonderiSayisi();
  //   if (mounted) {
  //     setState(() {
  //       _notGonderiSayisi = notGonderiSayisi;
  //     });
  //   }
  // }

  // _esyaGonderiSayisiGetir() async {
  //   int esyaGonderiSayisi = await FirestoreServisi().esyaGonderiSayisi();
  //   if (mounted) {
  //     setState(() {
  //       _esyaGonderiSayisi = esyaGonderiSayisi;
  //     });
  //   }
  // }

  // _evArkadasiGonderiSayisiGetir() async {
  //   int evArkadasiGonderiSayisi =
  //       await FirestoreServisi().evArkadasiGonderiSayisi();
  //   if (mounted) {
  //     setState(() {
  //       _evArkadasiGonderiSayisi = evArkadasiGonderiSayisi;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // _yolculukGonderiSayisiGetir();
    // _notGonderiSayisiGetir();
    // _evArkadasiGonderiSayisiGetir();
    // _esyaGonderiSayisiGetir();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: MelihColors().acikGri,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: _height * 0.1,
                ),
                Text(
                  'Ne Yüklemek İstiyorsun?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: _height / 40,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: _height * 0.065,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EvArkadasiIlanEkle()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: _width * 0.4,
                            height: _height * 0.25,
                            color: MelihColors().acikacikGri,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Icon(
                                  FontAwesomeIcons.userFriends,
                                  color: MelihColors().main,
                                  size: _width * 0.15,
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
                                      'Ev Arkadaşı\nİlanları',
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
                                // Row(
                                //   children: [
                                //     SizedBox(
                                //       width: _width * 0.025,
                                //     ),
                                //     Text(
                                //       "Görünür İlan Sayınız: " +
                                //           _evArkadasiGonderiSayisi.toString(),
                                //       style: TextStyle(
                                //           color: MelihColors().white,
                                //           fontWeight: FontWeight.normal,
                                //           fontSize: _height / 45),
                                //     )
                                //   ],
                                // ),
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EsyaIlanEkle()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: _width * 0.4,
                            height: _height * 0.25,
                            color: MelihColors().acikacikGri,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Icon(
                                  FontAwesomeIcons.shoppingCart,
                                  color: MelihColors().amber,
                                  size: _width * 0.15,
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
                                // Row(
                                //   children: [
                                //     SizedBox(
                                //       width: _width * 0.025,
                                //     ),
                                //     Text(
                                //       'İlan Sayısı 2',
                                //       style: TextStyle(
                                //           color: MelihColors().white,
                                //           fontWeight: FontWeight.normal,
                                //           fontSize: _height / 45),
                                //     )
                                //   ],
                                // ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _height * 0.075,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YolculukIlanEkle()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: _width * 0.4,
                            height: _height * 0.25,
                            color: MelihColors().acikacikGri,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Icon(
                                  FontAwesomeIcons.car,
                                  color: MelihColors().red,
                                  size: _width * 0.15,
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
                                // Row(
                                //   children: [
                                //     SizedBox(
                                //       width: _width * 0.025,
                                //     ),
                                //     Text(
                                //       "İlan Sayısı " +
                                //           _yolculukGonderiSayisi.toString(),
                                //       style: TextStyle(
                                //           color: MelihColors().white,
                                //           fontWeight: FontWeight.normal,
                                //           fontSize: _height / 45),
                                //     )
                                //   ],
                                // ),
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotIlanEkle()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: _width * 0.4,
                            height: _height * 0.25,
                            color: MelihColors().acikacikGri,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Icon(
                                  FontAwesomeIcons.book,
                                  color: MelihColors().green,
                                  size: _width * 0.15,
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
                                          fontSize: _height / 45),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: _height * 0.006,
                                ),
                                // Row(
                                //   children: [
                                //     SizedBox(
                                //       width: _width * 0.025,
                                //     ),
                                //     Text(
                                //       'İlan Sayısı 2',
                                //       style: TextStyle(
                                //           color: MelihColors().white,
                                //           fontWeight: FontWeight.normal,
                                //           fontSize: _height / 45),
                                //     )
                                //   ],
                                // ),
                              ],
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
