import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/widgets/chat/messages.dart';
import 'package:messenger_app/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions: [
          DropdownButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text('Logout'),
                  ],
                ),
              )
            ],
            onChanged: (value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: SizedBox(
          child: Column(
            children: [
              Expanded(
                child: Messages(),
              ),
              Divider(),
              NewMessage(),
            ],
          ),
        ),
      ),
    );
  }
}
