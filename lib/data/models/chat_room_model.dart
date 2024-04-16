class ChatRoomModel {
  String id;
  String lastMessage;
  String sender;
  String? updatedOn;
  List<String> participants;

  ChatRoomModel({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.updatedOn,
    required this.sender,
  });

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      id: map['id'],
      participants: (map['participants'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      // convert each element of list to string manually
      sender: map['sender'] ?? "",
      lastMessage: map['last_message'] ?? "",
      updatedOn: map['updated_on'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'participants': participants,
      'last_message': lastMessage,
      'updated_on': updatedOn,
      'sender': sender
    };
  }

  @override
  String toString() {
    return '''
    {
       id: $id, 
       participants: $participants,
       lastMessage: $lastMessage,
       updatedOn: $updatedOn,
       sender: $sender,
    }    
    ''';
  }
}
