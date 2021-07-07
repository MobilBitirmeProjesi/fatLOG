import 'package:flutter/material.dart';

class Bossayfa extends StatefulWidget {
  @override
  _BossayfaState createState() => _BossayfaState();
}

class _BossayfaState extends State<Bossayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(child: Text("Tarifler", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),),
          ),
          Image.asset(
            "images/yemek1.jpg",
            width: 150,
            height: 150,
          ),
          Text("Akdeniz diyetinde dikkat edilmesi gerekenler:"),
          Text("")
        ],
      ),
    );
  }
}
