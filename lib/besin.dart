import 'package:bitirme_projesi_/anasayfa.dart';
import 'package:bitirme_projesi_/besinekle.dart';
import 'package:bitirme_projesi_/gecmiseklenenler.dart';
import 'package:bitirme_projesi_/profil.dart';
import 'package:bitirme_projesi_/servisler/firestoreservisi.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';

class Besin extends StatefulWidget {
  final String profilSahibiId;

  const Besin({Key key, this.profilSahibiId}) : super(key: key);
  @override
  _BesinState createState() => _BesinState();
}
int kilotmp;
class _BesinState extends State<Besin> {
  @override
  Widget build(BuildContext context) {
    //FireStoreServisi().
    return Scaffold(
      body: FutureBuilder<Object>(
        future: FireStoreServisi().kullaniciGetir(widget.profilSahibiId),
        builder: (context, snapshot) {

          return ListView(
            children: <Widget>[
              _besinFonk(context),
              //oneriOlusturFonksiyonu(snapshot.data),
            ],
          );
        }
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.history,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFFE0C332),
        onPressed: () {
          //Geçmiş Sayfasına Gitsin
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => GecmisEklenenler()),
          );
        },
      ),
    );
  }

  Container _besinFonk(BuildContext context) {
    return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 3),
                height: 90,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange],
                  ),
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
                            "Yenilen Gıda Verisi Ekle",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //OneriOlustur();
                      oneriOlusturFonksiyonu();
                    },
                    child: Text("Öneri Oluştur"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      shadowColor: Colors.redAccent,
                      elevation: 5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}

void oneriOlusturFonksiyonu()
{
  //Fluttertoast.showToast(msg: "Fonksiyona Girildi.");
  var rng = new Random();

  int gereken_D_Vit = 100;
  int gereken_A_Vit = 100;
  int gereken_E_Vit = 100;
  int gereken_K_Vit = 100;


  int alinan_A_Vit = rng.nextInt(67)+33;
  int alinan_D_Vit = rng.nextInt(67)+33;
  int alinan_E_Vit = rng.nextInt(67)+33;
  int alinan_K_Vit = rng.nextInt(67)+33;


  String yiyecekAd;
  List<String> besinler = List (6);
  besinler[0]="Elma";
  besinler[1]="Armut";
  besinler[2]="Muz";
  besinler[3]="Portakal";
  besinler[4]="Kivi";
  besinler[5]="Ananas";
  List<int> degerlerA = List (6);
  degerlerA[0]=25;
  degerlerA[1]=18;
  degerlerA[2]=5;
  degerlerA[3]=21;
  degerlerA[4]=12;
  degerlerA[5]=35;
  List<int> degerlerD = List (6);
  degerlerD[0]=10;
  degerlerD[1]=7;
  degerlerD[2]=23;
  degerlerD[3]=47;
  degerlerD[4]=25;
  degerlerD[5]=17;
  List<int> degerlerE = List (6);
  degerlerE[0]=42;
  degerlerE[1]=27;
  degerlerE[2]=11;
  degerlerE[3]=3;
  degerlerE[4]=46;
  degerlerE[5]=2;
  List<int> degerlerK = List (6);
  degerlerK[0]=20;
  degerlerK[1]=15;
  degerlerK[2]=18;
  degerlerK[3]=11;
  degerlerK[4]=22;
  degerlerK[5]=18;

  List<String> onerilecekler = List ();
  List<double> onerilenDegerler = List ();

  List<int> tmpArray = List (4);
  tmpArray[0] = alinan_A_Vit;
  tmpArray[1] = alinan_D_Vit;
  tmpArray[2] = alinan_E_Vit;
  tmpArray[3] = alinan_K_Vit;
  //Fluttertoast.showToast(msg: "1.For dongusu baslangici");
  for (int ax = 0; ax < besinler.length; ax++) {
    //Fluttertoast.showToast(msg: "1.For dongusune Girildi.");
    if(((tmpArray[0]+degerlerA[ax]/gereken_A_Vit) > 1) && ((tmpArray[1]+degerlerD[ax])/gereken_D_Vit > 1) && ((tmpArray[2]+degerlerE[ax])/gereken_E_Vit > 1) && ((tmpArray[3]+degerlerK[ax])/gereken_K_Vit > 1))
    {
      onerilecekler.add(besinler[ax]);
      onerilenDegerler.add(((tmpArray[0]+degerlerA[ax])/gereken_A_Vit) + ((tmpArray[1]+degerlerD[ax])/gereken_D_Vit) + ((tmpArray[2]+degerlerE[ax])/gereken_E_Vit) + ((tmpArray[3]+degerlerK[ax])/gereken_K_Vit)/4);
    }
    for(int bx=ax; bx<besinler.length ;bx++){
      if(((tmpArray[0]+degerlerA[ax]+degerlerA[bx])/gereken_A_Vit > 1) && ((tmpArray[1]+degerlerD[ax]+degerlerD[bx])/gereken_D_Vit > 1) && ((tmpArray[2]+degerlerE[ax]+degerlerE[bx])/gereken_E_Vit > 1) && ((tmpArray[3]+degerlerK[ax]+degerlerK[bx])/gereken_K_Vit > 1))
      {
        onerilecekler.add(besinler[ax] + " " + besinler[bx]);
        onerilenDegerler.add(((tmpArray[0]+degerlerA[ax]+degerlerA[bx])/gereken_A_Vit) + ((tmpArray[1]+degerlerD[ax]+degerlerD[bx])/gereken_D_Vit) + ((tmpArray[2]+degerlerE[ax]+degerlerE[bx])/gereken_E_Vit) + ((tmpArray[3]+degerlerK[ax]+degerlerK[bx])/gereken_K_Vit)/4);
      }
      for(int cx=bx;cx<besinler.length;cx++) {
        if(((tmpArray[0]+degerlerA[ax]+degerlerA[bx]+degerlerA[cx])/gereken_A_Vit > 1) && ((tmpArray[1]+degerlerD[ax]+degerlerD[bx]+degerlerD[cx])/gereken_D_Vit > 1) && ((tmpArray[2]+degerlerE[ax]+degerlerE[bx]+degerlerE[cx])/gereken_E_Vit > 1) && ((tmpArray[3]+degerlerK[ax]+degerlerK[bx]+degerlerK[cx])/gereken_K_Vit > 1))
        {
          onerilecekler.add(besinler[ax] + " " + besinler[bx] + " " + besinler[cx]);
          onerilenDegerler.add(((tmpArray[0]+degerlerA[ax]+degerlerA[bx]+degerlerA[cx])/gereken_A_Vit) + ((tmpArray[1]+degerlerD[ax]+degerlerD[bx]+degerlerD[cx])/gereken_D_Vit) + ((tmpArray[2]+degerlerE[ax]+degerlerE[bx]+degerlerE[cx])/gereken_E_Vit) + ((tmpArray[3]+degerlerK[ax]+degerlerK[bx]+degerlerK[cx])/gereken_K_Vit)/4);
        }
      }
    }
  }
  //Fluttertoast.showToast(msg: "1.For dongusu cikis.");
  if(onerilenDegerler.length > 0)
  {
    String degisken = onerilecekler[onerilenDegerler.indexOf(onerilenDegerler.reduce(min))];
    for(final vElement in besinler){
      vElement.allMatches(degisken).length;
      tmpArray[0] += (vElement.allMatches(degisken).length * degerlerA[besinler.indexOf(vElement)]);
      tmpArray[1] += (vElement.allMatches(degisken).length * degerlerD[besinler.indexOf(vElement)]);
      tmpArray[2] += (vElement.allMatches(degisken).length * degerlerE[besinler.indexOf(vElement)]);
      tmpArray[3] += (vElement.allMatches(degisken).length * degerlerK[besinler.indexOf(vElement)]);
    }
    int tmparray0 = tmpArray[0];
    int tmparray1 = tmpArray[1];
    int tmparray2 = tmpArray[2];
    int tmparray3 = tmpArray[3];
    Fluttertoast.showToast(msg: "$tmparray0");
    Fluttertoast.showToast(msg: "$tmparray1");
    Fluttertoast.showToast(msg: "$tmparray2");
    Fluttertoast.showToast(msg: "$tmparray3");
    double ortalama = (tmpArray[0]/gereken_A_Vit+tmpArray[1]/gereken_D_Vit+tmpArray[2]/gereken_E_Vit+tmpArray[3]/gereken_K_Vit)/4;
    Fluttertoast.showToast(msg: "Ort :  $ortalama");
  }


  String deger123 = onerilecekler[onerilenDegerler.indexOf(onerilenDegerler.reduce(min))];


  Fluttertoast.showToast(msg: "Sonuç =>  $deger123");

}