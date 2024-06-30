import 'package:chat_app/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

class PhoneHome extends StatefulWidget {
  const PhoneHome({super.key});

  @override
  State<PhoneHome> createState() => _PhoneHomeState();
}

class _PhoneHomeState extends State<PhoneHome> {
  TextEditingController phonenumber = TextEditingController();

  sendcode() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+977' + phonenumber.text,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar("Error occured", e.code);
          },
          codeSent: (String vid, int? token) {
            Get.to(OtpPage(vid: vid));
          },
          codeAutoRetrievalTimeout: (vid) {});
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error ", e.code);
    } catch (e) {
      Get.snackbar("Error ", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: Text(
              "Enter your Phone No.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          phonetext(),
          SizedBox(
            height: 20,
          ),
          button(),
        ],
      ),
    );
  }

  Widget button() {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            sendcode();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              "Recieve OTP",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  Widget phonetext() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: phonenumber,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            prefix: Text("+977"),
            prefixIcon: Icon(Icons.phone),
            labelText: "Enter phone Number",
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))),
      ),
    );
  }
}
