import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/signup_page.dart';
import 'package:flutter_todo/services/auth_service.dart';

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
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () async {
              await authClass.logOut();
              Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => SignUpPage()),
              (route) => false);
            },
            icon: Icon(Icons.logout))
      ]),
    );
  }
}
