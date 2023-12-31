import 'package:chat_app/features/chat_page/domain/entities/chat.dart';
import 'package:intl/intl.dart';

class ChatModel extends Chat {
  const ChatModel({
    required super.senderId,
    required super.receiverId,
    required super.dateTime,
    required super.message,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        dateTime: DateFormat.Hm().format(DateTime.parse(json["dateTime"])),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "senderId": senderId,
        "receiverId": receiverId,
        "dateTime": dateTime,
        "message": message,
      };
}
