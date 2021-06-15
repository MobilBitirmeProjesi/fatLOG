import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BesinEkle extends StatefulWidget {
  @override
  _BesinEkleState createState() => _BesinEkleState();
}

class _BesinEkleState extends State<BesinEkle> {
  //Verileri Kontrollerden Alıcı
  TextEditingController yiyecekAd = TextEditingController();
  TextEditingController birim = TextEditingController();
  TextEditingController miktar = TextEditingController();
  TextEditingController vakit = TextEditingController();
  verileriKaydet() async {
    FirebaseAuth yetki = FirebaseAuth.instance;
    final FirebaseUser mevcutKullanici = await yetki.currentUser();

    String uidTutucu = mevcutKullanici.uid;
    var zamanTutucu = DateTime.now();

    await Firestore.instance
        .collection("Yiyecekler")
        .document(uidTutucu)
        .collection("Sabah")
        .document(zamanTutucu.toString())
        .setData({
      "yiyecekAd": yiyecekAd.text,
      "birim": birim.text,
      "miktar": miktar.text,
      "ogunVakti": vakit.text,
      "zaman": zamanTutucu.toString(),
      "tamZaman": zamanTutucu
    });

    Fluttertoast.showToast(msg: "Yiyecek Başarıyla Eklendi");
  }

  String _dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yiyecek Ekle"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
            controller: vakit,
              decoration: InputDecoration(
                labelText: "Öğün Vakti",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: yiyecekAd,
              decoration: InputDecoration(
                labelText: "Yiyecek Adı",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: miktar,
              decoration: InputDecoration(
                labelText: "Miktar(Porsiyon, Gram, Adet...)",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: birim,
              decoration: InputDecoration(
                labelText: "Birim",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            height: 70,
            width: double.infinity,
            child: ElevatedButton(
              child: Text(
                "Yiyeceği Kaydet",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                //Görev Firebase'e Eklenecek
                verileriKaydet();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF4CAF50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
