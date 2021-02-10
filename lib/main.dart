import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uludag_social/models/colorsAndTypes.dart';
import 'package:uludag_social/services/yetkilendirmeServisi.dart';
import 'package:uludag_social/yonlendirme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<YetkilendirmeServisi>(
      create: (_) => YetkilendirmeServisi(),
      child: MaterialApp(
        title: 'Uludağ Social',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(primary: MelihColors().main)),
            cursorColor: Color(0xff7289da),
            primaryColor: Color(0xff7289da),
            primarySwatch: Colors.indigo),
        home: Yonlendirme(),
      ),
    );
  }
}
