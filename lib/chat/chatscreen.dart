// import 'package:chat_app/auth/auth_services.dart';
// import 'package:chat_app/chat/chat_page.dart';
// import 'package:chat_app/chat/chat_services.dart';
// import 'package:chat_app/components/usertile.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({
//     super.key,
//   });

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {

//   signOut() async {
//     await FirebaseAuth.instance.signOut();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("chat"),
//       ),
//       // body:
//       // StreamBuilder(
//       //     stream: _chatService.getUserStream(),
//       //     builder: (context, snapshot) {
//       //       if (snapshot.hasError) {
//       //         return const Text("error");
//       //       }
//       //       if (snapshot.connectionState == ConnectionState.waiting) {
//       //         return const Text("Loading");
//       //       }
//       //       return ListView(
//       //         children: snapshot.data!
//       //             .map<Widget>((userData) => _buildItem(userData, context))
//       //             .toList(),
//       //       );
//       //     }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           signOut();
//         },
//         child: Icon(Icons.logout_outlined),
//       ),
//     );
//   }

//   Widget _buildItem(Map<String, dynamic> userData, BuildContext context) {
//     return UserTile(
//         text: userData["name"],
//         onTap: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => ChatInbox(
//                         receiverName: userData["name"],
//                       )));
//         });
//   }
// }

import 'package:chat_app/auth/auth_services.dart';
import 'package:chat_app/chat/chat_page.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/repo/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerWidget {
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final userRepository = ref.read(userRepositoryProvider);

    final authRepository = ref.read(authRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: userRepository.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('An error occurred'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found'));
          }

          List<UserModel> users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              UserModel user = users[index];

              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.phoneNumber),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(receiverId: user.uid),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authRepository.signOut(context);
        },
        child: Icon(Icons.logout_outlined),
      ),
    );
  }
}
