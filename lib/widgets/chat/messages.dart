import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future<User>.value(FirebaseAuth.instance.currentUser),
      builder: (context, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .orderBy(
                'createdTime',
                descending: true,
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = snapshot.data!.docs;
            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (context, index) => MessageBubble(
                message: chatDocs[index]['text'],
                userName: chatDocs[index]['username'],
                userImage: chatDocs[index]['userImage'],
                isMe: chatDocs[index]['userId'] == futureSnapshot.data?.uid,
                messageKey: ValueKey(chatDocs[index].id),
              ),
            );
          },
        );
      },
    );
  }
}
