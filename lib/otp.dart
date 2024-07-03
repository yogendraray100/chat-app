import 'package:chat_app/auth/auth_controller.dart';
import 'package:chat_app/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends ConsumerWidget {
  final String verificationId;
  const OtpPage({super.key, required this.verificationId});

  // Future<void> signIn() async {
  //   PhoneAuthCredential credential =
  //       PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: code);

  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);

  //     User? user = userCredential.user;
  //     if (user != null) {
  //       // Check if the user is new
  //       if (userCredential.additionalUserInfo?.isNewUser ?? false) {
  //         // Save the user information to Firestore
  //         await FirebaseFirestore.instance
  //             .collection('Users')
  //             .doc(user.uid)
  //             .set({
  //           'phoneNumber': user.phoneNumber,
  //           'createdAt': FieldValue.serverTimestamp(),
  //           // Add other user details here if needed
  //         });
  //       }

  //       Get.offAll(Wrapper());
  //     }

  //     // await FirebaseAuth.instance
  //     //     .signInWithCredential(credential)
  //     //     .then((value) => Get.offAll(Wrapper()));
  //   } on FirebaseAuthException catch (e) {
  //     Get.snackbar("Error ", e.code);
  //   } catch (e) {
  //     Get.snackbar("Error ", e.toString());
  //   }
  // }

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
           Center(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Pinput(
          length: 6,
          onChanged: (value) {
            if (value.length == 6) {
              verifyOTP(ref, context, value.trim());
            }
          },
        ),
      ),
    ),
            SizedBox(
              height: 20,
            ),
            
          ],
        ),
      ),
    );
  }

  

  
}
