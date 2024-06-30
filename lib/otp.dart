import 'package:chat_app/wrapper.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  final String vid;
  const OtpPage({super.key, required this.vid});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  var code = '';
 

  signIn() async {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: widget.vid, smsCode: code);

    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) => Get.offAll(Wrapper()));

      
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error ", e.code);
    } catch (e) {
      Get.snackbar("Error ", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Text(
                "OTP Verification",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            textcode(),
            SizedBox(
              height: 20,
            ),
            button(),
          ],
        ),
      ),
    );
  }

  Widget button() {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            signIn();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              "Recieve OTP",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  Widget textcode() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Pinput(
          length: 6,
          onChanged: (value) {
            setState(() {
              code = value;
            });
          },
        ),
      ),
    );
  }
}
