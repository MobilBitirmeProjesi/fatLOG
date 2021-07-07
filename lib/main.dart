import 'package:bitirme_projesi_/anasayfa.dart';
import 'package:bitirme_projesi_/kayitekrani.dart';
import 'package:bitirme_projesi_/servisler/yetkilendirmeservisi.dart';
import 'package:bitirme_projesi_/yonlendirme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() {
  //runApp(Yapilacaklar());
  runApp(YonlendirmeFonk());
}

class Yapilacaklar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<YetkilendirmeServisi>(
      create: (_) => YetkilendirmeServisi(),
        child: MaterialApp(
          theme: ThemeData(
              //primaryColor: Color(0xFF35B535),
              // primarySwatch: Color(0xFF35B535),
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
        ),
    );
  }
}

class YonlendirmeFonk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<YetkilendirmeServisi>(
      create: (_) => YetkilendirmeServisi(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Yonlendirme(),
      ),
    );
  }
}
