import 'package:chat_app/auth/auth_controller.dart';
import 'package:chat_app/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

class PhoneHome extends ConsumerStatefulWidget {
  const PhoneHome({super.key});

  @override
  ConsumerState<PhoneHome> createState() => _PhoneHomeState();
}

class _PhoneHomeState extends ConsumerState<PhoneHome> {
  TextEditingController phoneController = TextEditingController();

  // sendcode() async {
  //   try {
  //     await FirebaseAuth.instance.verifyPhoneNumber(
  //         phoneNumber: '+977' + phoneNumber.text,
  //         verificationCompleted: (PhoneAuthCredential credential) async {
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //         },
  //         verificationFailed: (FirebaseAuthException e) {
  //           Get.snackbar("Error occured", e.code);
  //         },
  //         codeSent: ((String vid, int? token) async {
  //           Get.to(OtpPage(verificationId: vid));
  //         }),
  //         codeAutoRetrievalTimeout: (vid) {});
  //   } on FirebaseAuthException catch (e) {
  //     Get.snackbar("Error ", e.code);
  //   } catch (e) {
  //     Get.snackbar("Error ", e.toString());
  //   }
  // }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();

    if (phoneNumber.isNotEmpty) {
      ref.read(authControllerProvider).signInWithPhone(context, "+977$phoneNumber");
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
            sendPhoneNumber();
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
        controller: phoneController,
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
