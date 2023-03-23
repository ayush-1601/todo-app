import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/addTodoPage.dart';
import 'package:flutter_todo/pages/home_page.dart';
import 'package:flutter_todo/pages/signup_page.dart';
import 'package:flutter_todo/pages/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_todo/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = SignUpPage();

  AuthClass authClass = AuthClass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != Null) {
      setState(() {
        currentPage = HomePage();
      });
    }
  }

  // firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return currentPage;
  }
}
