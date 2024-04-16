import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lets_chat/data/models/message_model.dart';
import 'package:lets_chat/data/repository/chat_repository.dart';
import 'package:uuid/uuid.dart';

class ChatRoomProvider with ChangeNotifier {
  TextEditingController chatController = TextEditingController();

  Future<void> sendMessage({
    required String chatRoomId,
  }) async {
    String text = chatController.text.trim();

    if (text.isNotEmpty) {
      chatController.clear();
      final myUid = FirebaseAuth.instance.currentUser!.uid;

      MessageModel newMessage = MessageModel(
        uid: const Uuid().v1(),
        message: text,
        senderUid: myUid,
        createdOn: DateTime.now().toIso8601String(),
      );

      ChatRepository.sendMessage(chatRoomId, newMessage);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessageStream(
    String chatRoomId,
  ) {
    return ChatRepository.getMessageStream(chatRoomId);
  }

  bool isMineMessage(String senderId) {
    String myUid = FirebaseAuth.instance.currentUser!.uid;

    return myUid.compareTo(senderId) == 0;
  }
}
