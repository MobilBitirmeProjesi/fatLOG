import 'package:bitirme_projesi_/kayitformu.dart';
import 'package:bitirme_projesi_/modeller/kullanici.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServisi {
  final Firestore _firestore = Firestore.instance;
  final DateTime zaman = DateTime.now();

  Future<void> kullaniciOlustur({id, email, kullaniciAdi, kilo, boy, yas}) async {
    await _firestore.collection("Kullanicilar").document(id).setData(
    {
      "kullaniciAdi": kullaniciAdi,
      "email": email,
      "kilo": kilo,
      "boy": boy,
      "yas": yas,
      "olusturulmaZamani": zaman
    });
  }

  Future<Kullanici> kullaniciGetir(id) async {
    DocumentSnapshot doc = await _firestore.collection("Kullanicilar").document(id).get();
    if(doc.exists){
      Kullanici kullanici = Kullanici.dokumandanUret(doc);
      return kullanici;
    }
    return null;
  }

  kiloGetir(id) async {
    //DocumentSnapshot doc = await _firestore.collection("Kullanicilar").document(id).collection("kilo").get();
  }

}