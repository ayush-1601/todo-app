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
    return SafeArea(
      child: Scaffold(
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
              preferredSize: Size.fromHeight(40)),
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
              icon: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => SignUpPage()));
                },
                child: Icon(
                  Icons.logout,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              label: "")
        ]),
        body: StreamBuilder(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    IconData iconData;
                    Color iconColor;
                    Map<String, dynamic> document = snapshot.data.docs[index]
                        .data() as Map<String, dynamic>;

                    switch (document["category"]) {
                      case "Health":
                        iconData = Icons.health_and_safety_outlined;
                        iconColor = Colors.cyan;
                        break;
                      case "Study":
                        iconData = CupertinoIcons.book_circle;
                        iconColor = Colors.green;
                        break;
                      case "Market":
                        iconData = Icons.shopping_bag_outlined;
                        iconColor = Colors.blueGrey;
                        break;
                      case "Office":
                        iconData = CupertinoIcons.briefcase;
                        iconColor = Colors.red;
                        break;
                      case "Groceries":
                        iconData = Icons.local_grocery_store_outlined;
                        iconColor = Colors.deepPurple;
                        break;
                      case "Workout":
                        iconData = Icons.run_circle_outlined;
                        iconColor = Colors.white;
                        break;
                      default:
                        iconData = Icons.alarm_add_outlined;
                        iconColor = Colors.black;
                    }
                    selected.add(Select(
                        id: snapshot.data.docs[index].id, checkValue: false));

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
                        title: document["title"] == ""
                            ? "add title"
                            : document["title"],
                        check: selected[index].checkValue,
                        iconData: iconData,
                        iconBgcolor: iconColor,
                        time: "10 AM",
                        iconColor: Colors.orangeAccent,
                        index: index,
                        onChange: onChange,
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
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
