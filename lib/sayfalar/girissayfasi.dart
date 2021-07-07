import 'package:bitirme_projesi_/sayfalar/hesapolustur.dart';
import 'package:bitirme_projesi_/servisler/yetkilendirmeservisi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  final _formAnahtari = GlobalKey<FormState>();
  final _scaffoldAnahtari = GlobalKey<ScaffoldState>();
  bool yukleniyor = false;
  String email,parola;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _sayfaElemanlari(),
          _yuklemeAnimasyonu(),
        ],
      ),
    );
  }

  Widget _yuklemeAnimasyonu(){
    if(yukleniyor){
      return Center(child: CircularProgressIndicator());
    } else {
      return Center();
    }
  }

  Widget _sayfaElemanlari() {
    return Form(
      key: _formAnahtari,
      child: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        children: [
          SizedBox(
            height: 40.0,
          ),
          Image.asset(
            "images/logo.png",
            width: 200,
            height: 200,
          ),
          //SizedBox(height: 30.0,),
          TextFormField(
            autocorrect: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Lütfen E-mail Adresinizi Giriniz",
              prefixIcon: Icon(Icons.mail),
            ),
            validator: (girilenDeger) {
              if (girilenDeger.isEmpty) {
                return "E-mail Alanı Boş Bırakılamaz!";
              } else if (!girilenDeger.contains("@")) {
                return "Lütfen E-mail Adresini Doğru Formatta Giriniz!";
              }
              return null;
            },
            onSaved: (girilenDeger) => email = girilenDeger,
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Lütfen Parolanızı Giriniz",
              prefixIcon: Icon(Icons.vpn_key),
            ),
            validator: (girilenDeger) {
              if (girilenDeger.isEmpty) {
                return "Parola Alanı Boş Bırakılamaz!";
              } else if (girilenDeger.trim().length < 6) {
                return "Parola En Az 6 Karakter Olmalıdır!";
              }
              return null;
            },
            onSaved: (girilenDeger) => parola = girilenDeger,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HesapOlustur()));
                  },
                  child: Text(
                    "Kayıt Ol",
                    style: TextStyle(),
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: _girisYap,
                  child: Text(
                    "Giriş Yap",
                    //style: TextStyle(),
                    //color: Colors.red,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF35B535),
                    shadowColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.red.shade700,
              shadowColor: Colors.black,
            ),
            child: Text("Parolamı Unuttum"),
          )
          //Center(child: Text("Parolamı Unuttum"),),
        ],
      ),
    );
  }

  void _girisYap() async {
    final _yetkilendirmeServisi = Provider.of<YetkilendirmeServisi>(context, listen: false);
    if (_formAnahtari.currentState.validate()) {
      _formAnahtari.currentState.save();
      setState(() {
        yukleniyor = true;
      });
      try {
        await _yetkilendirmeServisi.mailIleGiris(email, parola);
      } catch (hata) {

        var snackBar = SnackBar(content: Text(hata.code));
        _scaffoldAnahtari.currentState.showSnackBar(snackBar);
      }

    }
  }
}
