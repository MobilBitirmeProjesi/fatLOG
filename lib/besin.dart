import 'package:bitirme_projesi_/anasayfa.dart';
import 'package:bitirme_projesi_/besinekle.dart';
import 'package:bitirme_projesi_/gecmiseklenenler.dart';
import 'package:bitirme_projesi_/profil.dart';
import 'package:flutter/material.dart';

class Besin extends StatefulWidget {
  @override
  _BesinState createState() => _BesinState();
}

class _BesinState extends State<Besin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 3),
              height: 90,
              decoration: BoxDecoration(
                color: Color(0xFFE0C332),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Sabah Vakti",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle),
                      onPressed: () {
                        //Besin Ekleme Sayfasına Gitsin
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => BesinEkle()),
                        );
                        //debugPrint("Ekleme Butonu");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.history,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFFE0C332),
        onPressed: () {
          //Görev Ekleme Sayfasına Gitsin
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => GecmisEklenenler()),
          );
        },
      ),
    );
  }
}
