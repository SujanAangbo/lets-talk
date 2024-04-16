import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../chat_room_page.dart';
import '../chat_room_provider/chat_room_provider.dart';

class SendMessageContainer extends StatelessWidget {
  const SendMessageContainer({
    super.key,
    required this.chatRoomProvider,
    required this.widget,
  });

  final ChatRoomProvider chatRoomProvider;
  final ChatRoomPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: chatRoomProvider.chatController,
              maxLines: 5,
              minLines: 1,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: "Type your message",
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              chatRoomProvider.sendMessage(chatRoomId: widget.chatRoom.id);
            },
            icon: Icon(
              Icons.send,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
