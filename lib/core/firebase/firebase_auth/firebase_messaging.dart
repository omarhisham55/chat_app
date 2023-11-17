
import 'package:chat_app/features/chat_page/domain/entities/chat.dart';

abstract class FirebaseMessaging {
  Future<void> sendMessages({
    required String senderId,
    required String receiverId,
    required String dateTime,
    required String message,
  });
  List<Chat> getMessages({
    required String senderId,
    required String receiverId,
  });
}
