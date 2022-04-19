import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../consts.dart';
import '../../home/home_screen.dart';


class LoginButton extends StatefulWidget {
  final Size size;
  final TextEditingController entryEmail;
  final TextEditingController entryPass;
  final String title;
  LoginButton({
    required this.title,
    required this.entryEmail,
    required this.entryPass,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          //Email ve Şifre yardımı ile oturum açılmasını sağlar
          UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(
            email: widget.entryEmail.text,
            password: widget.entryPass.text,
          );
          print(widget.entryEmail.text);
          print(widget.entryPass.text);
          setState(() {
            circular = false;
          });
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        } catch (error) {
          final snackbar = SnackBar(
            content: Text("$error"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
          rethrow;
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: widget.size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.black, Colors.black54, Colors.black12],
            stops: [0.0, 0.4, 0.9],
          ),
        ),
        child: Center(
          child: circular
              ? CircularProgressIndicator()
              : Text(
                 widget.title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
