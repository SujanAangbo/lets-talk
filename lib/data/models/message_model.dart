import 'package:lets_chat/data/models/user_model.dart';

class MessageModel {
  String uid;
  String message;
  String senderUid;
  String createdOn;

  MessageModel({
    required this.uid,
    required this.message,
    required this.senderUid,
    required this.createdOn,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      uid: map['uid'],
      message: map['message'],
      senderUid: map['sender'],
      createdOn: map['created_on'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'message': message,
      'sender': senderUid,
      'created_on': createdOn,
    };
  }

  @override
  String toString() {
    return '''
      {
        uid: $uid,
        message: $message,
        sender: $senderUid,
        createdOn: $createdOn
      }
    ''';
  }
}
