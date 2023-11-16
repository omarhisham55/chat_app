import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String senderId;
  final String receiverId;
  final String dateTime;
  final String message;

  const Chat({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.message,
  });

  @override
  List<Object> get props => [dateTime, message];
}
