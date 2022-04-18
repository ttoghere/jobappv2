import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobappv2/auth_service.dart';
import 'package:jobappv2/screens/home/home_screen.dart';
import 'package:jobappv2/screens/login/login_screen.dart';
import 'package:jobappv2/screens/phone/phone_auth.dart';

import 'firebase_options.dart';
import 'screens/sign_up/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = SignUp();
  AuthServiceClass authServiceClass = AuthServiceClass();
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authServiceClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = HomeScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUp.routeName: (context) => SignUp(),
        PhoneAuthScreen.routeName: (context) => PhoneAuthScreen(),
      },
      home: currentPage,
    );
  }
}
