import 'package:bitirme_projesi_/anasayfa.dart';
import 'package:bitirme_projesi_/modeller/kullanici.dart';
import 'package:bitirme_projesi_/servisler/firestoreservisi.dart';
import 'package:bitirme_projesi_/servisler/yetkilendirmeservisi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HesapOlustur extends StatefulWidget {
  @override
  _HesapOlusturState createState() => _HesapOlusturState();
}

class _HesapOlusturState extends State<HesapOlustur> {
  bool yukleniyor = false;
  final _formAnahtari = GlobalKey<FormState>();
  final _scaffoldAnahtari = GlobalKey<ScaffoldState>();
  String kullaniciAdi,email,parola,kilo,boy,yas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldAnahtari,
      body: ListView(
        children: <Widget>[
          yukleniyor
              ? LinearProgressIndicator()
              : SizedBox(
                  height: 0.0,
                ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formAnahtari,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: "Lütfen Kullanıcı Adınızı Giriniz",
                      labelText: "Kullanıcı Adı",
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger.isEmpty) {
                        return "Kullanıcı Adı Alanı Boş Bırakılamaz!";
                      }
                      return null;
                    },
                    onSaved: (girilenDeger) => kullaniciAdi = girilenDeger,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Lütfen E-mail Adresinizi Giriniz",
                      labelText: "E-mail",
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
                    height: 10.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Lütfen Parolanızı Giriniz",
                      labelText: "Parola",
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
                    onSaved: (girilenDeger){
                      parola = girilenDeger;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Lütfen Kilo Bilginizi Giriniz",
                      labelText: "Kilo(KG)",
                      prefixIcon: Icon(Icons.featured_play_list),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger.isEmpty) {
                        return "Kilo Alanı Boş Bırakılamaz!";
                      }
                      return null;
                    },
                    onSaved: (girilenDeger) => kilo = girilenDeger,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Lütfen Boy Bilginizi Giriniz",
                      labelText: "Boy(Cm)",
                      prefixIcon: Icon(Icons.featured_play_list),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger.isEmpty) {
                        return "Boy Alanı Boş Bırakılamaz!";
                      }
                      return null;
                    },
                    onSaved: (girilenDeger) => boy = girilenDeger,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Lütfen Yaşınızı Giriniz",
                      labelText: "Yaş",
                      prefixIcon: Icon(Icons.featured_play_list),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger.isEmpty) {
                        return "Yaş Alanı Boş Bırakılamaz!";
                      }
                      return null;
                    },
                    onSaved: (girilenDeger) => yas = girilenDeger,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: _kullaniciOlustur,
                    child: Text(
                      "Kaydı Tamamla",
                      //style: TextStyle(),
                      //color: Colors.red,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF35B535),
                      shadowColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _kullaniciOlustur() async {
    final _yetkilendirmeServisi = Provider.of<YetkilendirmeServisi>(context, listen:false);

    var _formState = _formAnahtari.currentState;
    if(_formState.validate()){
      _formState.save();
      setState(() {
        yukleniyor = true;
      });

      try {
        Kullanici kullanici = await _yetkilendirmeServisi.mailIleKayit(email, parola);
        if(kullanici != null){
          FireStoreServisi().kullaniciOlustur(id: kullanici.id, email: email, kullaniciAdi: kullaniciAdi, kilo: kilo, boy: boy, yas: yas);
        }
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AnaSayfa()));
      } catch(hata) {
        setState(() {
          yukleniyor=false;
        });
        var snackBar = SnackBar(content: Text(hata.code));
        _scaffoldAnahtari.currentState.showSnackBar(snackBar);
      }

    }
  }
}
