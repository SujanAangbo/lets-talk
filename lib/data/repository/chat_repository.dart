import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_chat/data/models/message_model.dart';

class ChatRepository {
  static Future<void> sendMessage(
      String chatRoomId, MessageModel message) async {
    try {
      final collections = FirebaseFirestore.instance.collection('chat_rooms');
      collections
          .doc(chatRoomId)
          .collection('messages')
          .doc(message.uid)
          .set(message.toMap());

      final lastMessageMap = {
        "sender": message.senderUid,
        "last_message": message.message,
        "updated_on": DateTime.now().toIso8601String()
      };

      collections.doc(chatRoomId).update(lastMessageMap);
      log("Message sent successfully");
    } catch (e) {
      log("error: ${e.toString()}");
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessageStream(
    String chatRoomId,
  ) {
    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('created_on', descending: true)
        .snapshots();
  }
}
