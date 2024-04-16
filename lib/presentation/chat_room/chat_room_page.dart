import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/core/colors.dart';
import 'package:lets_chat/data/models/chat_room_model.dart';
import 'package:lets_chat/data/models/message_model.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/presentation/chat_room/chat_room_provider/chat_room_provider.dart';
import 'package:lets_chat/presentation/chat_room/widgets/send_message_container.dart';
import 'package:lets_chat/presentation/chat_room/widgets/show_message_widget.dart';
import 'package:lets_chat/presentation/home/home_page.dart';
import 'package:lets_chat/presentation/widgets/cached_circle_image.dart';
import 'package:lets_chat/presentation/widgets/default_progress_bar.dart';
import 'package:lets_chat/presentation/widgets/error_message_widget.dart';
import 'package:lets_chat/presentation/widgets/gap_widget.dart';
import 'package:provider/provider.dart';

class ChatRoomPage extends StatefulWidget {
  static const String routeName = "/chat_room";

  ChatRoomModel chatRoom;
  UserModel friend;

  ChatRoomPage({
    super.key,
    required this.chatRoom,
    required this.friend,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  Widget build(BuildContext context) {
    final chatRoomProvider = Provider.of<ChatRoomProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pushReplacementNamed(context, HomePage.routeName);
        //   },
        // ),
        titleSpacing: 0,
        title: Row(
          children: [
            CachedCircleImage(
              imageUrl: widget.friend.profile!,
              size: 40,
            ),
            const GapWidget(
              size: -8,
            ),
            Text(
              widget.friend.name ?? "Unknown",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // for chats
            Expanded(
              child: StreamBuilder(
                  stream: chatRoomProvider.getMessageStream(widget.chatRoom.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return ErrorMessageWidget(
                        message: "Unable to fetch chats",
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const DefaultProgressBar();
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.size == 0) {
                        return ErrorMessageWidget(
                          message: "Say hi to start conversation!",
                        );
                      } else {
                        return ShowMessageWidget(
                          messageData: snapshot.data,
                          chatRoomProvider: chatRoomProvider,
                        );
                      }
                    }
                    return ErrorMessageWidget(
                      message: "Something went wrong",
                    );
                  }),
            ),
            SendMessageContainer(
                chatRoomProvider: chatRoomProvider, widget: widget)
          ],
        ),
      ),
    );
  }
}
