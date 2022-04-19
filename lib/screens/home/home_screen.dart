import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:jobappv2/auth_service.dart';
import 'package:jobappv2/screens/todo/todo_screen.dart';
import 'package:jobappv2/screens/todo/widgets/todo_card.dart';
import 'package:jobappv2/screens/todo/widgets/todo_edit.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/hs";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthServiceClass authServiceClass = AuthServiceClass();
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();
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
          title: Text(
            "Today's Schedule",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottom: PreferredSize(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: Text(
                  "Monday 21",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(35),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black87,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 32,
                color: Colors.white,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.red[900]!, Colors.yellow[900]!],
                  ),
                ),
                child: IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(TodoScreen.routeName),
                  icon: Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 32,
                color: Colors.white,
              ),
              label: "",
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> document =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                IconData iconData;
                Color iconColor;
                switch (document["Category"]) {
                  case "Work":
                    iconData = Icons.run_circle_outlined;
                    iconColor = Colors.white;
                    break;
                  case "WorkOut":
                    iconData = Icons.alarm;
                    iconColor = Colors.yellow[900]!;
                    break;
                  case "Food":
                    iconData = Icons.local_grocery_store;
                    iconColor = Colors.blue[900]!;
                    break;
                  case "Design":
                    iconData = Icons.audiotrack_rounded;
                    iconColor = Colors.pink[900]!;
                    break;
                  default:
                    iconData = Icons.run_circle_outlined;
                    iconColor = Colors.red[900]!;
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditTodos(
                              document: document,
                              id: snapshot.data!.docs[index].id,
                            )));
                  },
                  child: TodoCard(
                    title: document["title"] == null
                        ? "Hey There"
                        : document["title"],
                    iconData: iconData,
                    iconColor: iconColor,
                    time: "10 PM",
                    check: true,
                    iconBgColor: Colors.red[200]!,
                  ),
                );
              },
            );
          },
        ));
  }
}
