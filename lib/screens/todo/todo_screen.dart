import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  static const routeName = "/ts";
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.red[900]!,
            Colors.orange[900]!,
            Colors.yellow[900]!,
          ], stops: [
            0.0,
            0.5,
            1.0,
          ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "New Todo",
                      style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    label(label: "Task Title"),
                    SizedBox(
                      height: 12,
                    ),
                    title(),
                    SizedBox(
                      height: 12,
                    ),
                    label(label: "Task Type"),
                    Row(
                      children: [
                        chipData(label: "Important", color: Colors.red[200]!),
                        SizedBox(
                          width: 20,
                        ),
                        chipData(label: "Planned", color: Colors.orange[200]!)
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    label(label: "Description"),
                    SizedBox(
                      height: 12,
                    ),
                    description(),
                    SizedBox(
                      height: 25,
                    ),
                    label(label: "Category"),
                    SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        chipData(label: "Workout", color: Colors.blue[200]!),
                        SizedBox(
                          width: 20,
                        ),
                        chipData(label: "Work", color: Colors.green[200]!),
                        SizedBox(
                          width: 20,
                        ),
                        chipData(label: "Design", color: Colors.purple[200]!),
                        SizedBox(
                          width: 20,
                        ),
                        chipData(label: "Run", color: Colors.yellow[200]!),
                        SizedBox(
                          width: 20,
                        ),
                        chipData(label: "Food", color: Colors.pink[200]!),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    button(),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container button() {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            colors: [Colors.red, Colors.red[900]!, Colors.red[100]!],
            stops: [0.0, 0.5, 0.8]),
      ),
      child: Center(
        child: Text(
          "Add Todo",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Chip chipData({required String label, required Color color}) {
    return Chip(
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 17,
          color: Colors.grey[900],
          fontWeight: FontWeight.bold,
        ),
      ),
      labelPadding: EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 3.8,
      ),
    );
  }

  Container title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xFF2A2E3D),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(
            fontSize: 17,
            color: Colors.red[900],
          ),
        ),
      ),
    );
  }

  Container description() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xFF2A2E3D),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(
            fontSize: 17,
            color: Colors.red[900],
          ),
        ),
        maxLines: null,
      ),
    );
  }

  Text label({required String label}) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16.5,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.2,
      ),
    );
  }
}
