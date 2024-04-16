import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../data/models/message_model.dart';
import '../chat_room_provider/chat_room_provider.dart';

class ShowMessageWidget extends StatelessWidget {
  QuerySnapshot<Map<String, dynamic>>? messageData;
  final ChatRoomProvider chatRoomProvider;

  ShowMessageWidget({
    super.key,
    required this.messageData,
    required this.chatRoomProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messageData!.size,
      itemBuilder: (context, index) {
        Map<String, dynamic> messageMap = messageData!.docs[index].data();
        MessageModel message = MessageModel.fromMap(messageMap);
        return Row(
          mainAxisAlignment: chatRoomProvider.isMineMessage(message.senderUid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.65),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              decoration: BoxDecoration(
                color: chatRoomProvider.isMineMessage(message.senderUid)
                    ? Colors.blue
                    : Colors.grey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: Text(
                message.message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
