import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class ViewCardPage extends StatefulWidget {
  const ViewCardPage({super.key, required this.document, required this.id});
  final Map<String, dynamic> document;
  final String id;

  @override
  State<ViewCardPage> createState() => _ViewCardPageState();
}

class _ViewCardPageState extends State<ViewCardPage> {
  late TextEditingController _taskController;
  late TextEditingController _descController;
  late String type;
  late String category;
  bool edit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String title = widget.document["title"] == null
        ? "task title"
        : widget.document["title"];
    _taskController = TextEditingController(text: title);
    _descController =
        TextEditingController(text: widget.document["description"]);
    type = widget.document["task"];
    category = widget.document["category"];
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.white,
                        size: 30,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          edit = !edit;
                        });
                      },
                      icon: Icon(
                        Icons.edit,
                        color: edit ? Colors.amber : Colors.white,
                        size: 30,
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(edit ? "Editing" : "View",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4)),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Your Task",
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
                      categoryData("Food", Colors.greenAccent),
                      SizedBox(
                        width: 20,
                      ),
                      categoryData("class", Colors.blueAccent),
                      SizedBox(
                        width: 20,
                      ),
                      categoryData("study", Colors.purpleAccent),
                      SizedBox(
                        width: 20,
                      ),
                      categoryData("Run", Colors.cyanAccent),
                      SizedBox(
                        width: 20,
                      ),
                      categoryData("yoga", Colors.amberAccent),
                      SizedBox(
                        width: 20,
                      ),
                      categoryData("workout", Colors.cyan),
                    ]),
                    SizedBox(
                      height: 50,
                    ),
                    edit ? button() : Container(),
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
        FirebaseFirestore.instance.collection("todo").doc(widget.id).update({
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
            "Update Task",
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
        enabled: edit,
        controller: _descController,
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
    return InkWell(
      onTap: edit
          ? () {
              setState(() {
                type = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: type == label ? Colors.black : colr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 4),
      ),
    );
  }

  Widget categoryData(String label, Color colr) {
    return InkWell(
      onTap: edit
          ? () {
              setState(() {
                category = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: category == label ? Colors.black : colr,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
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
        enabled: edit,
        controller: _taskController,
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
