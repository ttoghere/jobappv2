import 'package:flutter/material.dart';
import 'package:jobappv2/screens/phone/phone_auth.dart';
import '../../consts.dart';
import '../sign_up/sign_up_screen.dart';
import '../sign_up/widgets/button_item.dart';
import '../sign_up/widgets/login_button.dart';
import '../sign_up/widgets/text_item.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/si";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void LoginScreen() async {
    try {
      //Belirtilen parametreler yardımı ile üye kayıdı yapılmasını sağlar
      await firebaseAuth.createUserWithEmailAndPassword(
        email: "tuncinyo12@gmail.com",
        password: "121233aa11",
      );
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  accountLogin() async {}

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              Text(
                "Sign In",
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
                onPress: () => Navigator.of(context).pushNamed(PhoneAuthScreen.routeName),
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
              LoginButton(
                  title: "Sign In",
                  entryEmail: _emailController,
                  entryPass: _passwordController,
                  size: size),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "If you don't have an account?",
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
                      Navigator.pushReplacementNamed(context, SignUp.routeName);
                    },
                    child: Text(
                      "Sign Up",
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
        ),
      ),
    );
  }
}
