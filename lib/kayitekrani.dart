import 'package:bitirme_projesi_/kayitformu.dart';
import 'package:flutter/material.dart';

class KayitSayfasi extends StatefulWidget {
  @override
  _KayitSayfasiState createState() => _KayitSayfasiState();
}

class _KayitSayfasiState extends State<KayitSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF35B535), Color(0xFF00563F)],
            ),
          ),
        ),
        title: Text("Kayıt Sayfası"),
        centerTitle: true,
      ),
      body: KayitFormu(),
    );
  }
}
