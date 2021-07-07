import 'package:bitirme_projesi_/modeller/kullanici.dart';
import 'package:bitirme_projesi_/servisler/firestoreservisi.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Profil extends StatefulWidget {
  final String profilSahibiId;

  const Profil({Key key, this.profilSahibiId}) : super(key: key);
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Object>(
        future: FireStoreServisi().kullaniciGetir(widget.profilSahibiId),
        builder: (context, snapshot) {
          /*if(!snapshot.data){
            return Center(child: CircularProgressIndicator());
          }*/
          return ListView(
            children: <Widget>[
              _profilBilgileri(snapshot.data),
            ],
          );
        }
      ),
    );
  }

  Column _profilBilgileri(Kullanici profilData) {
    return Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.green, Colors.green]
                    )
                ),
                child: Container(
                  width: double.infinity,
                  height: 350.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://sophia.smith.edu/blog/impressions/files/2018/05/user-3331257_960_720.png",
                          ),
                          radius: 50.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Muhammed Karadaş",
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5.0,
                        )
                      ],
                    ),
                  ),
                )
            ),

            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300.00,

              child: RaisedButton(
                  onPressed: (){},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)
                  ),
                  elevation: 0.0,
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Colors.grey,Colors.grey]
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text("Değiştir",
                        style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight:FontWeight.w300),
                      ),
                    ),
                  )
              ),
            ),
          ],
        );
  }
}


