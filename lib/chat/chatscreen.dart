import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String recieverPhone;
  const ChatPage({super.key, required this.recieverPhone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("chat"),
    ),);
  }
}
