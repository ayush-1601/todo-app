import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/signup_page.dart';
import 'package:flutter_todo/pages/todoCard.dart';
import 'package:flutter_todo/services/auth_service.dart';
import 'addTodoPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              TodoCard(
                title: "study",
                check: false,
                iconData: Icons.alarm,
                iconBgcolor: Colors.white,
                time: "10 AM",
                iconColor: Colors.pinkAccent,
              ),
              SizedBox(
                height: 15,
              ),
              TodoCard(
                title: "study",
                check: false,
                iconData: Icons.alarm,
                iconBgcolor: Colors.white,
                time: "10 AM",
                iconColor: Colors.pinkAccent,
              ),
              TodoCard(
                title: "study",
                check: false,
                iconData: Icons.alarm,
                iconBgcolor: Colors.white,
                time: "10 AM",
                iconColor: Colors.pinkAccent,
              ),
              SizedBox(
                height: 15,
              ),
              TodoCard(
                title: "study",
                check: false,
                iconData: Icons.alarm,
                iconBgcolor: Colors.white,
                time: "10 AM",
                iconColor: Colors.pinkAccent,
              ),
              SizedBox(
                height: 15,
              ),
              TodoCard(
                title: "study",
                check: false,
                iconData: Icons.alarm,
                iconBgcolor: Colors.white,
                time: "10 AM",
                iconColor: Colors.pinkAccent,
              ),
              SizedBox(
                height: 15,
              ),
              TodoCard(
                title: "study",
                check: false,
                iconData: Icons.alarm,
                iconBgcolor: Colors.white,
                time: "10 AM",
                iconColor: Colors.pinkAccent,
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
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
