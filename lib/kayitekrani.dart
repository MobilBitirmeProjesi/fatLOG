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
        title: Text("Kayıt Sayfası"),
        centerTitle: true,
      ),
      body: KayitFormu(),
    );
  }
}
