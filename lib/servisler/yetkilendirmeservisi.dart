import 'package:bitirme_projesi_/modeller/kullanici.dart';
import 'package:firebase_auth/firebase_auth.dart';

class YetkilendirmeServisi {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String aktifKullaniciId;

  Kullanici _kullaniciOlustur(FirebaseUser kullanici) {
    return kullanici == null ? null : Kullanici.firebasedenUret(kullanici);
  }

  Stream<Kullanici> get durumTakipcisi {
    return _firebaseAuth.onAuthStateChanged.map(_kullaniciOlustur);
  }

  Future<Kullanici> mailIleKayit(String eposta, String parola) async {
    var girisKarti = await _firebaseAuth.createUserWithEmailAndPassword(email: eposta, password: parola);
    return _kullaniciOlustur(girisKarti.user);
  }

  Future<Kullanici> mailIleGiris(String email, String parola) async {
    var girisKarti = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: parola);
    return _kullaniciOlustur(girisKarti.user);
  }

  Future<void> cikisYap(){
    return _firebaseAuth.signOut();
  }

}