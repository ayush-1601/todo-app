import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class phoneAuthPage extends StatefulWidget {
  const phoneAuthPage({super.key});

  @override
  State<phoneAuthPage> createState() => _phoneAuthPageState();
}

class _phoneAuthPageState extends State<phoneAuthPage> {
  int start = 30;
  bool wait = false;
  String buttonname = "Send";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(192, 0, 0, 0),
        title: Text("Sign Up"),
        titleTextStyle: TextStyle(fontSize: 25),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black87,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
              textfield(context),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 38,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                    Text(
                      " Enter 5 digit OTP ",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              otpTextField(context),
              SizedBox(
                height: 30,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Send OTP again in ",
                    style: TextStyle(fontSize: 18, color: Colors.yellow)),
                TextSpan(
                  text: "00:$start",
                  style: TextStyle(fontSize: 18, color: Colors.redAccent),
                ),
                TextSpan(
                  text: " sec",
                  style: TextStyle(fontSize: 18, color: Colors.yellow),
                )
              ])),

              SizedBox(
                height: 100,
              ),

              Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(25),
                ),

                child: Center(child: Text("Let's Go", style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white
                ),)),
              )

            ],
          ),
        ),
      ),
    );
  }

  void starttimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpTextField(BuildContext context) {
    return OTPTextField(
      length: 5,
      width: MediaQuery.of(context).size.width,
      fieldWidth: 70,
      otpFieldStyle: OtpFieldStyle(
          backgroundColor: Colors.black87, borderColor: Colors.white70),
      style: TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
      },
    );
  }

  Widget textfield(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      height: 80,
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white70),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your phone no.",
            contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            hintStyle: TextStyle(
              color: Colors.black54,
              fontSize: 18,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              child: Text(
                " (+91) ",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            suffixIcon: InkWell(
              onTap: wait
                  ? null
                  : (() {
                      starttimer();
                      setState(() {
                        wait = true;
                        buttonname = "Resend";
                        start = 30;
                      });
                    }),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                child: Text(
                  buttonname,
                  style: TextStyle(
                      color: wait ? Colors.grey : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
      ),
    );
  }
}
