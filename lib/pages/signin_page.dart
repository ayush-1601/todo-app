import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_todo/pages/home_page.dart';
import 'package:flutter_todo/pages/signup_page.dart';
import 'package:flutter_todo/services/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular = false;

  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              buttons("Continue with Google", "assets/google.svg", () async {
                await authClass.googleSignIn(context);
              }),
              buttons(
                  "Continue with Phone", "assets/mobile-phone.svg", (() {})),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Or",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              textbutton("Email", _emailController, false),
              const SizedBox(
                height: 10,
              ),
              textbutton("Password", _pwdController, true),
              const SizedBox(
                height: 20,
              ),
              signUpButton(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 15, color: Colors.white70),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => SignUpPage()),
                          (route) => false);
                    },
                    child: Text(
                      "Create here",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                  )
                ],
              ),
              const Text(
                "Forgot Password?",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buttons(String buttonText, String imgPath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 40,
        child: Card(
          elevation: 15,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.white70, width: 1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imgPath,
                height: 30,
                width: 30,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textbutton(
      String ltext, TextEditingController controller, bool obsecuretext) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width - 50,
      child: TextFormField(
        controller: controller,
        obscureText: obsecuretext,
        style: const TextStyle(color: Colors.white70),
        decoration: InputDecoration(
            labelText: ltext,
            labelStyle: const TextStyle(fontSize: 15, color: Colors.white70),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide:
                    const BorderSide(color: Colors.greenAccent, width: 4)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.white70, width: 1))),
      ),
    );
  }

  Widget signUpButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(
                  email: _emailController.text, password: _pwdController.text);
          print(userCredential.user);
          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomePage()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: const LinearGradient(
              colors: [Colors.indigoAccent, Colors.pinkAccent]),
        ),
        child: Center(
            child: circular
                ? CircularProgressIndicator(
                    color: Colors.indigoAccent,
                  )
                : Text(
                    "Sign In",
                    style: TextStyle(
                        color: Color.fromARGB(172, 0, 0, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
      ),
    );
  }
}
