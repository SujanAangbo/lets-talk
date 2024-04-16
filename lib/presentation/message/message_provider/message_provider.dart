import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lets_chat/data/models/chat_room_model.dart';
import 'package:lets_chat/data/models/chatroom_user_model.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/data/repository/auth_repository.dart';
import 'package:lets_chat/data/repository/chat_room_repository.dart';
import 'package:lets_chat/data/repository/database_repository.dart';
import 'package:flutter/foundation.dart';

class MessageProvider with ChangeNotifier {
  StreamSubscription? _chatSubscription;
  late List<ChatRoomUserModel> usersChatRooms;
  late bool isLoading;
  late bool isError;

  MessageProvider() {
    usersChatRooms = [];
    isLoading = true;
    isError = false;
    log("Home Provider Created");
    getAllChats();
  }

  bool isMe(String uid) {
    return FirebaseAuth.instance.currentUser!.uid.compareTo(uid) == 0;
  }

  Future<List<ChatRoomUserModel>?> getUserChatRoom() async {
    List<ChatRoomUserModel> chatRoomUsers = [];

    return chatRoomUsers;
  }

  void getAllChats() {
    // Fetch the chatRooms from the firebase firestore

    _chatSubscription =
        ChatRoomRepository.getAllMyChatRooms().listen((event) async {
      log("Listening");
      final chatRooms = event.docs.map((document) {
        Map<String, dynamic> chatRoomMap = document.data();
        print(chatRoomMap);
        final chatRoom = ChatRoomModel.fromMap(chatRoomMap);

        return chatRoom;
      }).toList();

      // to combine chatroom and user together
      usersChatRooms.clear();

      for (final chatRoom in chatRooms) {
        List<String> items = chatRoom.participants;
        items.remove(FirebaseAuth.instance.currentUser!.uid);

        UserModel? friend = await DatabaseRepository.getUserData(items[0]);

        if (friend != null) {
          ChatRoomUserModel chatUser =
              ChatRoomUserModel(chatRoom: chatRoom, user: friend);
          usersChatRooms.add(chatUser);
        }
      }
      isLoading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _chatSubscription?.cancel();
    // usersChatRooms = [];
    log("Message Provider destroyed");
    super.dispose();
  }
}
