import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
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
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                    size: 30,
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Create",
                        style: TextStyle(
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
                      chipData("planned", Colors.lightBlueAccent),
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
                      chipData("Food", Colors.greenAccent),
                      SizedBox(
                        width: 20,
                      ),
                      chipData("class", Colors.blueAccent),
                      SizedBox(
                        width: 20,
                      ),
                      chipData("abshdkjnks ", Colors.purpleAccent),
                      SizedBox(
                        width: 20,
                      ),
                      chipData("workout", Colors.cyanAccent),
                      SizedBox(
                        width: 20,
                      ),
                      chipData("workout", Colors.amberAccent),
                      SizedBox(
                        width: 20,
                      ),
                      chipData("workout", Colors.cyan),
                    ]),
                    SizedBox(
                      height: 50,
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
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient:
              LinearGradient(colors: [Colors.indigoAccent, Colors.pinkAccent])),
      child: Center(
        child: Text(
          "Add Task",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
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
        style: TextStyle(color: Colors.grey, fontSize: 20),
        maxLines: null,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Add description",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
            contentPadding: EdgeInsets.only(left: 20, right: 20)),
      ),
    );
  }

  Widget chipData(String label, Color colr) {
    return Chip(
      backgroundColor: colr,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      label: Text(
        label,
        style: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 4),
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
        style: TextStyle(color: Colors.grey, fontSize: 20),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "task title",
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
