import 'package:chat_app/chat/chat_services.dart';
import 'package:chat_app/chat/chatscreen.dart';
import 'package:chat_app/components/usertile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  
  final user = FirebaseAuth.instance.currentUser;
  final ChatService _chatService = ChatService();



  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      body: _builduserlist(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          signOut();
        },
        child: Icon(Icons.logout_outlined),
      ),
    );
  }

  Widget _builduserlist() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text("error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildUserListItem(userData , context))
                .toList(),
          );
        }));
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      recieverPhone: userData["phone"],
                    )));
      },
      text: userData["phone"],
    );
  }
}
