import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../models/chat_room_model.dart';

class ChatRoomRepository {
  static Future<ChatRoomModel?> getChatRoom(String friendUid) async {
    String myUid = FirebaseAuth.instance.currentUser!.uid;
    final storage = FirebaseFirestore.instance;

    try {
      // gets the list of all my friends
      QuerySnapshot dataSnapshot = await storage
          .collection('chat_rooms')
          .where('participants', arrayContains: myUid)
          .get();

      // filter the data with null if the another element is not the friend uid
      final mapList = dataSnapshot.docs.map((doc) {
        final mapData = doc.data() as Map<String, dynamic>;
        if ((mapData['participants'] as List<dynamic>).contains(friendUid)) {
          return mapData;
        }
      }).toList();

      // to remove null from the list
      mapList.remove(null);

      if (mapList.isEmpty) {
        // create new chatroom
        log("No chatroom created. Creating new chatroom");

        ChatRoomModel newChatroom = ChatRoomModel(
            id: const Uuid().v1(),
            participants: [friendUid, myUid],
            lastMessage: '',
            updatedOn: null,
            sender: '');

        await storage
            .collection('chat_rooms')
            .doc(newChatroom.id)
            .set(newChatroom.toMap());
        log("Chatroom created successfully");

        return newChatroom;
      } else {
        log("Chatroom already created");
        Map<String, dynamic> chatRoomMap = mapList[0] as Map<String, dynamic>;
        log(chatRoomMap.toString());

        ChatRoomModel existingChatroom = ChatRoomModel.fromMap(chatRoomMap);
        return existingChatroom;
      }
    } catch (e) {
      log("Error occurred: ${e.toString()}");
      return null;
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMyChatRooms() {
    String myUid = FirebaseAuth.instance.currentUser!.uid;
    final storage = FirebaseFirestore.instance;

    return storage
        .collection('chat_rooms')
        .where('participants', arrayContains: myUid)
        .where('updated_on', isNull: false)
        .orderBy('updated_on', descending: true)
        .snapshots();
    // .where('last_message', isNotEqualTo: "")
    // .orderBy('field')

    // todo: here we need to fix this unnecessary chat created
    /*
      QuerySnapshot dataSnapshot = await storage
          .collection('chat_rooms')
          .where('participants.$myUid', isEqualTo: true)
          // .where('last_message', isNotEqualTo: "")
          // .orderBy('field')
          .get();

      if (dataSnapshot.size == 0) {
        // create new chatroom
        log("No chats");
        return [];
      } else {
        List<ChatRoomModel> chatRooms = dataSnapshot.docs.map((e) {
          Map<String, dynamic> chatRoomMap = e.data() as Map<String, dynamic>;
          return ChatRoomModel.fromMap(chatRoomMap);
        }).toList();

        return chatRooms;
      }
    } catch (e) {
      log("Error occurred: ${e.toString()}");
      return null;
    }
    */
  }
}
