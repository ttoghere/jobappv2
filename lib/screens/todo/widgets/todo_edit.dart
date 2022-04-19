import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditTodos extends StatefulWidget {
  final Map<String, dynamic> document;
  final String id;
  EditTodos({
    Key? key,
    required this.document,
    required this.id,
  }) : super(key: key);

  @override
  State<EditTodos> createState() => _EditTodosState();
}

class _EditTodosState extends State<EditTodos> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String type = "";
  String category = "";
  bool edit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String title = widget.document["title"] == null
        ? "Hey There"
        : widget.document["title"];
    _titleController = TextEditingController(
      text: title,
    );
    String description = widget.document["description"] == null
        ? "Hey There"
        : widget.document["description"];
    TextEditingController _descriptionController =
        TextEditingController(text: description);
    type = widget.document["task"];
    category = widget.document["Category"];
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            edit = !edit;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: edit ? Colors.red : Colors.white,
                          size: 28,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Todo")
                              .doc(widget.id)
                              .delete()
                              .then((value) => Navigator.of(context).pop());
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
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
                      edit ? "Edit" : "View",
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
                      "Your Todo",
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
                        taskSelect(label: "Important", color: Colors.red[200]!),
                        SizedBox(
                          width: 20,
                        ),
                        taskSelect(label: "Planned", color: Colors.orange[200]!)
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
                        categorySelect(
                            label: "Workout", color: Colors.blue[200]!),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect(
                            label: "Work", color: Colors.green[200]!),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect(
                            label: "Design", color: Colors.purple[200]!),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect(
                            label: "Run", color: Colors.yellow[200]!),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect(label: "Food", color: Colors.pink[200]!),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    edit ? button() : Container(),
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

  Widget button() {
    return GestureDetector(
      onTap: () {
        FirebaseFirestore.instance.collection("Todo").doc(widget.id).update({
          "title": _titleController.text,
          "task": type,
          "Category": category,
          "description": _descriptionController.text,
        });
        Navigator.of(context).pop();
      },
      child: Container(
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
            edit ? "Edit Todo" : "Add Todo",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget taskSelect({required String label, required Color color}) {
    return GestureDetector(
      onTap: edit
          ? () {
              setState(() {
                type = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: type == label ? Colors.black : color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: type == label ? Colors.white : Colors.grey[900],
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget categorySelect({required String label, required Color color}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        backgroundColor: category == label ? Colors.black : color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 17,
            color: category == label ? Colors.white : Colors.grey[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xFF2A2E3D),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titleController,
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

  Widget description() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xFF2A2E3D),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _descriptionController,
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

  Widget label({required String label}) {
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
