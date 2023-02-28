import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/signup_page.dart';
import 'package:flutter_todo/pages/todoCard.dart';
import 'package:flutter_todo/pages/view_card.dart';
import 'package:flutter_todo/services/auth_service.dart';
import 'addTodoPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  List<Select> selected = [];

  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("todo").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Today schedule",
          style: TextStyle(fontSize: 35, color: Colors.white),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/google.svg"),
          ),
          SizedBox(
            width: 25,
          ),
        ],
        bottom: PreferredSize(
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 22),
                  child: Text(
                    "Monday",
                    style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                )),
            preferredSize: Size.fromHeight(35)),
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.black87, items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
              color: Colors.white,
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => AddTodoPage()));
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Colors.indigoAccent, Colors.purpleAccent])),
                child: Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 32,
              color: Colors.white,
            ),
            label: "")
      ]),
      body: StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              IconData iconData;
              Color iconColor;
              Map<String, dynamic> document =
                  snapshot.data.docs[index].data() as Map<String, dynamic>;

              switch (document["category"]) {
                case "Food":
                  iconData = Icons.food_bank;
                  iconColor = Colors.greenAccent;
                  break;
                case "study":
                  iconData = Icons.book_sharp;
                  iconColor = Colors.purpleAccent;
                  break;
                case "class":
                  iconData = Icons.school;
                  iconColor = Colors.blueAccent;
                  break;
                case "Run":
                  iconData = Icons.run_circle_outlined;
                  iconColor = Colors.cyanAccent;
                  break;
                case "yoga":
                  iconData = Icons.person;
                  iconColor = Colors.amberAccent;
                  break;
                case "workout":
                  iconData = Icons.alarm;
                  iconColor = Colors.cyan;
                  break;
                default:
                  iconData = Icons.run_circle_outlined;
                  iconColor = Colors.black;
              }
              selected.add(
                  Select(id: snapshot.data.docs[index].id, checkValue: false));

              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => ViewCardPage(
                                document: document,
                                id: snapshot.data.docs[index].id,
                              )));
                },
                child: TodoCard(
                  title:
                      document["title"] == "" ? "add title" : document["title"],
                  check: selected[index].checkValue,
                  iconData: iconData,
                  iconBgcolor: iconColor,
                  time: "10 AM",
                  iconColor: Colors.pinkAccent,
                  index: index,
                  onChange: onChange,
                ),
              );
            },
          );
        },
      ),
    );
  }

  void onChange(int index) {
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }
}

class Select {
  String id;
  bool checkValue = false;
  Select({required this.id, required this.checkValue});
}


// IconButton(
//             onPressed: () async {
//               await authClass.logOut();
//               Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (builder) => SignUpPage()),
//               (route) => false);
//             },
//             icon: Icon(Icons.logout))
