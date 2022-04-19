import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../consts.dart';
import '../login/login_screen.dart';
import '../phone/phone_auth.dart';
import 'widgets/button_item.dart';
import 'widgets/sign_up_button.dart';
import 'widgets/text_item.dart';

class SignUp extends StatefulWidget {
  static const routeName = "/su";
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  void signUp() async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: "tuncinyo12@gmail.com",
        password: "121233aa11",
      );
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  var status = true;
  var connectivity;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    connectivity = Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile) {
        status = true;
      } else if (event == ConnectivityResult.none) {
        status = false;
      }
    });
  }

  var battery = Battery();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: status ?? true
            ? Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red[100]!,
                      Colors.red[500]!,
                      Colors.red[900]!,
                      Colors.black,
                    ],
                    stops: [
                      0.0,
                      0.3,
                      0.6,
                      1.0,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<BatteryState>(
                        stream: battery.onBatteryStateChanged,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Please Charge your phone");
                          } else {
                            return Text(snapshot.data!.name);
                          }
                        }),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ButtonItem(
                      onPress: () => Navigator.of(context)
                          .pushNamed(PhoneAuthScreen.routeName),
                      imagePath: "svg/phone.svg",
                      buttonName: "Phone",
                      size: size,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Or",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextItem(
                      size: size,
                      labelN: "Email",
                      fieldControl: _emailController,
                      obsecure: false,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextItem(
                      size: size,
                      labelN: "Password",
                      fieldControl: _passwordController,
                      obsecure: true,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SignUpButton(
                      entryEmail: _emailController,
                      entryPass: _passwordController,
                      size: size,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "If you already have an account?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
