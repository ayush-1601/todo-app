import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController _taskController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  String type = "";
  String category = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.black87,
          Color.fromARGB(255, 40, 29, 99),
          Color.fromARGB(255, 17, 55, 120)
        ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    CupertinoIcons.chevron_back,
                    color: Colors.white,
                    size: 35,
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Create",
                        style: GoogleFonts.lato(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4)),
                    SizedBox(
                      height: 8,
                    ),
                    Text("a task",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4)),
                    SizedBox(
                      height: 30,
                    ),
                    label("Task Title"),
                    SizedBox(
                      height: 12,
                    ),
                    title(),
                    SizedBox(
                      height: 30,
                    ),
                    label("Task Type"),
                    SizedBox(
                      height: 12,
                    ),
                    Row(children: [
                      chipData("Important", Colors.redAccent),
                      SizedBox(
                        width: 20,
                      ),
                      chipData("Planned", Colors.lightBlueAccent),
                    ]),
                    SizedBox(
                      height: 30,
                    ),
                    label("Description"),
                    SizedBox(
                      height: 12,
                    ),
                    description(),
                    SizedBox(
                      height: 30,
                    ),
                    label("Category"),
                    SizedBox(
                      height: 12,
                    ),
                    Wrap(runSpacing: 10, children: [
                      categoryData("Study", Colors.green),
                      SizedBox(
                        width: 20,
                      ),
                      categoryData("Market", Colors.blueGrey),
                      SizedBox(
                        width: 20,
                      ),
                      categoryData("Groceries", Colors.deepPurple),
                      SizedBox(
                        width: 20,
                      ),
                      categoryData("Health", Colors.cyan),
                      SizedBox(
                        width: 20,
                      ),
                      categoryData("Office", Colors.red),
                      SizedBox(
                        width: 20,
                      ),
                      categoryData("Workout", Colors.orange),
                    ]),
                    SizedBox(
                      height: 30,
                    ),
                    button(),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("todo").add({
          "title": _taskController.text,
          "category": category,
          "task": type,
          "description": _descController.text,
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                colors: [Colors.indigoAccent, Colors.pinkAccent])),
        child: Center(
          child: Text(
            "Add Task",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
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
          color: Color.fromARGB(87, 102, 106, 122),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: _descController,
        style: TextStyle(color: Colors.grey, fontSize: 20),
        maxLines: null,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Add description...",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
            contentPadding: EdgeInsets.only(left: 20, right: 20)),
      ),
    );
  }

  Widget chipData(String label, Color colr) {
    return InkWell(
      onTap: () {
        setState(() {
          type = label;
        });
      },
      child: Chip(
        backgroundColor: type == label ? Colors.white : colr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
              color: type == label ? Colors.black : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 4),
      ),
    );
  }

  Widget categoryData(String label, Color colr) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        backgroundColor: category == label ? Colors.white : colr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
              color: category == label ? Colors.black : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 4),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color.fromARGB(87, 102, 106, 122),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: _taskController,
        style: TextStyle(color: Colors.grey, fontSize: 20),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Add task title...",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
            contentPadding: EdgeInsets.only(left: 20, right: 20)),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 0.2),
    );
  }
}
