import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_todo/pages/home_page.dart';
import 'package:flutter_todo/pages/signin_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black87,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign up",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              buttons("Continue with Google", "assets/google.svg"),
              buttons("Continue with Phone", "assets/mobile-phone.svg"),
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
                    "If you already have an account?",
                    style: TextStyle(fontSize: 15, color: Colors.white70),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => SignInPage()),
                          (route) => false);
                    },
                    child: Text(
                      "Login here",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buttons(String buttonText, String imgPath) {
    return Container(
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
                    const BorderSide(color: Colors.amberAccent, width: 1)),
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
              await firebaseAuth.createUserWithEmailAndPassword(
                  email: _emailController.text.toString().trim(),
                  password: _pwdController.text);
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
        width: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            Color(0xfffff8fb1),
            Color(0xffffce2db),
            Color(0xfffff8fb1)
          ]),
        ),
        child: Center(
            child: circular
                ? const CircularProgressIndicator()
                : Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Color.fromARGB(172, 0, 0, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
      ),
    );
  }
}
