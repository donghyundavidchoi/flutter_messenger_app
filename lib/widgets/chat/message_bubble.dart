import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;
  final Key messageKey;

  const MessageBubble({
    super.key,
    required this.message,
    required this.userName,
    required this.userImage,
    required this.isMe,
    required this.messageKey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
            ),
            child: CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage(userImage),
            ),
          ),
        Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: isMe
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.only(
                  topLeft: isMe
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomLeft: const Radius.circular(12),
                  topRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomRight: const Radius.circular(12),
                ),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
        if (isMe)
          Padding(
            padding: const EdgeInsets.only(
              right: 8,
            ),
            child: CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage(userImage),
            ),
          ),
      ],
    );
  }
}
