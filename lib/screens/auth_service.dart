import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobappv2/screens/sign_up/sign_up_screen.dart';

class AuthServiceClass {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FlutterSecureStorage();
  Future<void> storeTokenAndData(UserCredential userCredential) async {
    await storage.write(
        key: "token", value: userCredential.credential!.token.toString());
    await storage.write(
        key: "userCredential", value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<void> logOut(BuildContext context) async {
    try {
      await auth.signOut();
      await storage.delete(key: "token");
      Navigator.of(context).pushNamed(SignUp.routeName);
    } catch (e) {}
  }
}
