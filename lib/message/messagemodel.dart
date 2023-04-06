


class Message {
  int? id;
  int? senderId;
  int? receiverId;
  String? message;

  Message({this.id, this.senderId, this.receiverId, this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['body'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'senderId': senderId,
    'receiverId': receiverId,
    'body': message,
  };
}
