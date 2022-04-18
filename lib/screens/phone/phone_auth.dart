import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jobappv2/auth_service.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class PhoneAuthScreen extends StatefulWidget {
  static const routeName = "/pa";
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneTextControl = TextEditingController();
  AuthServiceClass auth = AuthServiceClass();
  String verificationId = "";
  String smsCode = "";
  void startTimer() {
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

  void setData(verificationId) {
    setState(() {
      verificationId = verificationId;
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Sign Up",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              TextfieldContainer(context),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "Enter 6 Digit Otp",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: otpField(context)),
              SizedBox(
                height: 30,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Send OTP again in",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.yellowAccent,
                      ),
                    ),
                    TextSpan(
                      text: " 00:$start",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red[900],
                      ),
                    ),
                    TextSpan(
                      text: " sec ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.yellowAccent,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                  color: Color(0xFFFF9601),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Lets GO",
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFFFBE2AE),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OTPTextField otpField(BuildContext context) {
    return OTPTextField(
      length: 6,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(0xFF1D1D1D),
        borderColor: Colors.white,
      ),
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 58,
      style: TextStyle(
        fontSize: 17,
        color: Colors.white,
      ),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onChanged: (text) {
        print("Pin: $text");
      },
      onCompleted: (pin) {
        print("Completed: $pin");
      },
    );
  }

  Container TextfieldContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xFF1D1D1D),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: phoneTextControl,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: "Enter Your Phone Number",
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 19),
          fillColor: Colors.white,
          prefixIcon: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 19.0, horizontal: 8.0),
            child: Text(
              "+90",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: wait
                ? null
                : () async {
                    startTimer();
                    setState(() {
                      wait = true;
                      buttonName = "Reset";
                    });
                    await auth.verifyPhoneNumber(
                        "+90 ${phoneTextControl.text}", context, setData);
                  },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 19.0, horizontal: 8.0),
              child: Text(
                buttonName,
                style: TextStyle(
                  color: wait ? Colors.grey : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
            ),
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
