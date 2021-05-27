import 'package:bitirme_projesi_/anasayfa.dart';
import 'package:bitirme_projesi_/kayitekrani.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(Yapilacaklar());
}

class Yapilacaklar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //primaryColor: Color(0xFFE0C332),
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, kullaniciVerisi) {
            if (kullaniciVerisi.hasData) {
              return AnaSayfa();
            } else {
              return KayitSayfasi();
            }
          }),
    );
  }
}
