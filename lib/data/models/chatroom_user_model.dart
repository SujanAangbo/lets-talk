import 'package:lets_chat/data/models/chat_room_model.dart';
import 'package:lets_chat/data/models/user_model.dart';

class ChatRoomUserModel {
  ChatRoomModel chatRoom;
  UserModel user;

  ChatRoomUserModel({required this.chatRoom, required this.user});
}
