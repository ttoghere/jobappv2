import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobappv2/auth_service.dart';
import 'package:jobappv2/screens/home/home_screen.dart';
import 'package:jobappv2/screens/login/login_screen.dart';
import 'package:jobappv2/screens/phone/phone_auth.dart';
import 'package:jobappv2/screens/todo/todo_screen.dart';

import 'firebase_options.dart';
import 'screens/sign_up/sign_up_screen.dart';

void main() async {
  //Gerekli olan Flutter Widgetlarının başlatılmasını sağlar
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase yapısının uygulama içinde aktif başlamasını sağlar
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
    authServiceClass.signOut(context);
    checkLogin();
  }
  //Giriş durumunun token kontrolünü sağlar
  void checkLogin() async {
    //Eğer token durumu varsa anasayfaya yoksa kayıt sayfasına yönlendirme durumunu sağlar
    String? token = await authServiceClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = HomeScreen();
      });
    } else {
      currentPage = SignUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUp.routeName: (context) => SignUp(),
        PhoneAuthScreen.routeName: (context) => PhoneAuthScreen(),
        TodoScreen.routeName: (context) => TodoScreen(),
      },
      home: currentPage,
    );
  }
}
