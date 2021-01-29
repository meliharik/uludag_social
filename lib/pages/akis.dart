import 'package:flutter/material.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';

class Akis extends StatefulWidget {
  @override
  _AkisState createState() => _AkisState();
}

class _AkisState extends State<Akis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MelihColors().acikGri,
      body: Center(
        child: Text(
          'Akış',
          style: TextStyle(color: MelihColors().white),
        ),
      ),
    );
  }
}
