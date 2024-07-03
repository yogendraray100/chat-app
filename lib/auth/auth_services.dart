import 'package:chat_app/chat/chatscreen.dart';
import 'package:chat_app/login.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/otp.dart';
import 'package:chat_app/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  void signInWithPhone(String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar("Error occured", e.code);
          },
          codeSent: ((String verificationId, int? resendtoken) async {
            Get.to(OtpPage(verificationId: verificationId));
          }),
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error ", e.code);
    }
  }

  void verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String userOTP}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOTP);
      await auth.signInWithCredential(credential);
      Get.offAll(Wrapper());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error ", e.code);
    }
  }

  void saveUserDataToFirebase(
      {required String name,
      required ProviderRef ref,
      required BuildContext context}) async {
    try {
      String uid = auth.currentUser!.uid;
      var user =
          UserModel(name: name, uid: uid, phoneNumber: auth.currentUser!.uid);
      await firestore.collection("users").doc(uid).set(user.toMap());
      Get.to(ChatPage());
    } catch (e) {}
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await auth.signOut();
      Get.offAll(
          PhoneHome()); // Navigate to login or welcome page after signing out
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
