import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class PhoneAuthScreen extends StatefulWidget {
  static const routeName = "/pa";
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
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
              TextFieldContainer(),
              SizedBox(
                height: 30,
              ),
              OtpField(),
            ],
          ),
        ),
      ),
    );
  }
}

class OtpField extends StatelessWidget {
  const OtpField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      onCompleted: (pin) {
        print("Compleated: $pin");
      },
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xFF1D1D1D),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Enter Your Phone Number",
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 19),
          fillColor: Colors.white,
          prefixIcon: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 19.0, horizontal: 8.0),
            child: Text(
              "+91",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
          ),
          suffixIcon: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 19.0, horizontal: 8.0),
            child: Text(
              "Send",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
