import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OneriOlustur extends StatefulWidget {
  @override
  _OneriOlusturState createState() => _OneriOlusturState();
}

class _OneriOlusturState extends State<OneriOlustur> {
  int gereken_D_Vit = 100;
  int gereken_A_Vit = 100;
  int gereken_E_Vit = 100;
  int gereken_K_Vit = 100;
  double gereken_n3_yag = 0.5;
  double gereken_n6_yag = 4.4;

  int alinan_A_Vit = 44;
  int alinan_D_Vit = 55;
  int alinan_E_Vit = 33;
  int alinan_K_Vit = 66;
  double alinan_n3_yag = 5.0;
  double alinan_n6_yag = 4.4;

  String yiyecekAd;
  List<String> yiyecekler = List();

  //--Mevcut Kullanici uidsi
  String mevcutkullaniciUidTutucu;

  //İlk Sayfa Açıldığında
  @override
  void initState() {
    // TODO: implement initState
    mevcutKullaniciUidsiAl();
    super.initState();
  }

  mevcutKullaniciUidsiAl() async {
    //Veritabanından Uid Al
    FirebaseAuth yetki = FirebaseAuth.instance;
    final FirebaseUser mevcutKullanici = await yetki.currentUser();

    setState(() {
      mevcutkullaniciUidTutucu = mevcutKullanici.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("Yiyecekler")
              .document(mevcutkullaniciUidTutucu)
              .collection("Sabah")
              .snapshots(),
          builder: (context, veriTabanindanGelenVeriler) {
            if (veriTabanindanGelenVeriler.connectionState ==
                ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final alinanVeri = veriTabanindanGelenVeriler.data.documents;
              return ListView.builder(
                itemCount: alinanVeri.length,
                itemBuilder: (context, index) {
                  //Eklenme Zamanı Tutucu
                  var eklenmeZamani =
                      (alinanVeri[index]["tamZaman"] as Timestamp).toDate();
                  yiyecekler.add((alinanVeri[index]["yiyecekAd"]).toString());
                  oneri(yiyecekler);
                  return Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 3),
                    height: 90,
                    decoration: BoxDecoration(
                      color: Color(0xFFE0C332),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 5, color: Colors.grey),
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
                                alinanVeri[index]["yiyecekAd"],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

void oneri(yiyecekler){
  debugPrint(yiyecekler[0]);
  print("yiyecekler: ${yiyecekler[0]}");
  for (int i = 0; i < 2; i++) {
    print("a");
  }
}
