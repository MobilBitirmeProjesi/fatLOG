import 'package:bitirme_projesi_/HomePage.dart';
import 'package:bitirme_projesi_/besin.dart';
import 'package:bitirme_projesi_/bossayfa.dart';
import 'package:bitirme_projesi_/kayitekrani.dart';
import 'package:bitirme_projesi_/profil.dart';
import 'package:bitirme_projesi_/sayfalar/girissayfasi.dart';
import 'package:bitirme_projesi_/servisler/yetkilendirmeservisi.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}


class _AnaSayfaState extends State<AnaSayfa> {
  int navBarItem = 0;
  String text1 = "Ana Sayfa", text2 = "Öneri", text3 = "Öğünler", text4 = "Profil";
  //String aktifKullaniciId = Provider.of<YetkilendirmeServisi>(context, listen: false).aktifKullaniciId;

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
    String aktifKullaniciId = Provider.of<YetkilendirmeServisi>(context, listen: false).aktifKullaniciId;
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
                        builder: (_) => GirisSayfasi(),
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
              icon: Icon(Icons.lightbulb),
              label: text2,
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_dining),
              label: text3,
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity),
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
