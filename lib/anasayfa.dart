import 'package:bitirme_projesi_/HomePage.dart';
import 'package:bitirme_projesi_/besin.dart';
import 'package:bitirme_projesi_/bossayfa.dart';
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
  String text1 = "Ana Sayfa", text2 = "Öneri", text3 = "Öğünler", text4 = "Profil";
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Besin(),
    Bossayfa(),
    Profil(),
  ];
  int _currentIndex = 0;
  final List<Widget> _children = [];
  void onTappedBar(int index)
  {
    setState(() {
      _currentIndex = index;
    });
  }
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
        title: Text("fatLOG"),
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
        //onTap: onTappedBar,
        //currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.green,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: text1,
              backgroundColor: Colors.green),

          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: text2,
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: text3,
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: text4,
              backgroundColor: Colors.green),

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
