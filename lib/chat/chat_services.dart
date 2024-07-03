// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Stream<List<Map<String, dynamic>>> getUserStream() {
//     return _firestore.collection("users").snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) {
//         final user = doc.data();

//         return user;
//       }).toList();
//     });
//   }

//   Future<void> sendMessage(String receiverId, message) async {
//     final Timestamp timestamp = Timestamp.now();

    
//   }
// }

import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class ChatRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ChatRepository({
    required this.auth,
    required this.firestore,
  });

  Future<void> sendMessage({
    required String receiverId,
    required String message,
  }) async {
    try {
      String senderId = auth.currentUser!.uid;
      MessageModel newMessage = MessageModel(
        senderId: senderId,
        receiverId: receiverId,
        message: message,
        timestamp: DateTime.now(),
      );

      await firestore
          .collection('chats')
          .doc(senderId)
          .collection(receiverId)
          .add(newMessage.toMap());

      await firestore
          .collection('chats')
          .doc(receiverId)
          .collection(senderId)
          .add(newMessage.toMap());
    } catch (e) {
      print(e);
    }
  }

  Stream<List<MessageModel>> getMessages(String receiverId) {
    String senderId = auth.currentUser!.uid;
    return firestore
        .collection('chats')
        .doc(senderId)
        .collection(receiverId)
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
