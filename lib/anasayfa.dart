import 'package:bitirme_projesi_/kayitekrani.dart';
import 'package:bitirme_projesi_/profil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int navBarItem = 0;
  String text1 = "AnaSayfa", text2 = "Yediklerim", text3 = "Ekle", text4 = "Profilim";
  List<Widget> _widgetOptions = <Widget>[
    ProfilSayfasi(),
    ProfilSayfasi(),
    ProfilSayfasi(),
    ProfilSayfasi(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnaSayfa"),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((user) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => KayitSayfasi(),
                      ),
                      (route) => false);
                });
              })
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: text1,
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: text2,
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: text3,
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: text4,
              backgroundColor: Colors.blue),

        ],
        currentIndex: navBarItem,
        onTap: (index){
          setState(() {
            navBarItem = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(navBarItem),
    );
  }
}
