import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                "Sign In",
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
              textbutton("Email"),
              const SizedBox(
                height: 10,
              ),
              textbutton("Password"),
              const SizedBox(
                height: 20,
              ),
              signUpButton(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 15, color: Colors.white70),
                  ),
                  Text(
                    "Create here",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
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

  Widget textbutton(String ltext) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width - 50,
      child: TextFormField(
        style: const TextStyle(color: Colors.white70),
        decoration: InputDecoration(
            labelText: ltext,
            labelStyle: const TextStyle(fontSize: 15, color: Colors.white70),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.white70, width: 1))),
      ),
    );
  }

  Widget signUpButton() {
    return Container(
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
      child: const Center(
          child: Text(
        "Sign Up",
        style: TextStyle(
            color: Color.fromARGB(172, 0, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      )),
    );
  }
}
