import 'package:chat_app/features/chat_page/domain/entities/record.dart';
import 'package:intl/intl.dart';

class RecordModel extends Record {
  const RecordModel({
    required super.senderId,
    required super.receiverId,
    required super.dateTime,
    required super.message,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
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
