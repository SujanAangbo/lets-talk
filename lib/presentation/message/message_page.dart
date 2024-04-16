import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/presentation/message/message_provider/message_provider.dart';
import 'package:provider/provider.dart';

import '../../data/models/chatroom_user_model.dart';
import '../../logic/formatters/formatters.dart';
import '../chat_room/chat_room_page.dart';
import '../widgets/cached_circle_image.dart';
import '../widgets/default_progress_bar.dart';
import '../widgets/error_message_widget.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<MessageProvider>(context);

    return SafeArea(
      child: messageProvider.isLoading // to check if the data is fetching
          ? const DefaultProgressBar()
          : messageProvider.usersChatRooms
                  .isEmpty // to check if user have previous chat or not
              ? ErrorMessageWidget(
                  message: "No Conversations\nStart by searching friend")
              : ListView.builder(
                  itemCount: messageProvider.usersChatRooms.length,
                  itemBuilder: (context, index) {
                    ChatRoomUserModel friendChat =
                        messageProvider.usersChatRooms[index];
                    return ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      // textColor:
                      //     homeProvider.isMe(friendChat.chatRoom.sender)
                      //         ? Colors.grey[700]
                      //         : Colors.green,
                      title: Text(
                        friendChat.user.name ?? "Unknown",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        friendChat.chatRoom.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: CachedCircleImage(
                        imageUrl: friendChat.user.profile!,
                      ),
                      trailing: Text(Formatters.formatDateTime(
                            DateTime.tryParse(
                              friendChat.chatRoom.updatedOn.toString(),
                            ),
                          ) ??
                          ""),
                      onTap: () {
                        Map<String, dynamic> args = {
                          'chat_room': friendChat.chatRoom,
                          'friend': friendChat.user,
                        };
                        Navigator.pushNamed(context, ChatRoomPage.routeName,
                            arguments: args);
                      },
                    );
                  },
                ),
    );
  }
}
