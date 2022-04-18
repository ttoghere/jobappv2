import 'package:flutter/material.dart';
import 'package:jobappv2/auth_service.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/hs";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthServiceClass authServiceClass = AuthServiceClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => authServiceClass.logOut(context),
            icon: Icon(Icons.logout),
          ),
        ],
        title: Text("Home Screen"),
      ),
    );
  }
}
