import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobappv2/screens/sign_up/sign_up_screen.dart';

class AuthServiceClass {
  //Firebase auth için gerekli nesneyi oluşturur
  final FirebaseAuth auth = FirebaseAuth.instance;
  //Flutter içi depolama paketinin kullanımı için nesne oluşumu yapar
  final storage = FlutterSecureStorage();
  //Gelen token bilgisini hafızada tutup bilgilerin işlemini sağlar
  Future<void> storeTokenAndData(UserCredential userCredential) async {
    await storage.write(
        key: "token", value: userCredential.credential!.token.toString());
    await storage.write(
        key: "userCredential", value: userCredential.toString());
  }
  //Token içeriğinin gösterimini sağlar
  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }
  //Oturum Kapanışını sağlar ve kayıtlı olan token verisini siler
  Future<void> logOut(BuildContext context) async {
    try {
      await auth.signOut();
      await storage.delete(key: "token");
      Navigator.of(context).pushNamed(SignUp.routeName);
    } catch (e) {}
  }
  //Oturum kapanışı için gerekli olan alternatifi sağlar
  Future<void> signOut(BuildContext context) async {
    try {
      await auth.signOut();
      await storage.delete(key: "token");
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  //Telefon doğrulaması ve koşullarını belirtir
  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    //Doğrulamanın pozitif sonuçlanması sonunda oluşacak olan etkileşimi sağlar
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential) async {
      showSnackbar(context, "Verification Completed");
    };
    //Doğrulamanın negatif sonuçlanması sonunda oluşacak olan etkileşimi sağlar
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showSnackbar(context, "Verification Failed: $exception");
    };
    //Doğrulama kodu gönderimini sağlar
    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) {
      showSnackbar(context, "Verification code sent to your number");
      setData(verificationId);
    };
    //Doğrulama kodu girişi için gerekli olan kod süresi bitince oluşacak etkileşimi sağlar
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackbar(context, "Time Out");
    };
    //Telefon doğrulama için gerekli parametre yardımlı kullanım sağlar
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      showSnackbar(context, "Failed: $e");
    }
  }

  void showSnackbar(BuildContext context, String text) {
    final snackbar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
