import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../consts.dart';
import '../../home/home_screen.dart';


class SignUpButton extends StatefulWidget {
  final Size size;
  final TextEditingController entryEmail;
  final TextEditingController entryPass;
  SignUpButton({
    required this.entryEmail,
    required this.entryPass,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          UserCredential userCredential =
              await firebaseAuth.createUserWithEmailAndPassword(
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
                  "Sign Up",
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
