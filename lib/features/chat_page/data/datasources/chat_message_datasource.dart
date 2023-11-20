import 'package:chat_app/core/firebase/firebase_consumer/firebase_consumer.dart';
import 'package:chat_app/features/chat_page/domain/entities/chat.dart';

abstract class ChatMessageDatasource {
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String dateTime,
    required String message,
  });
  Stream<List<Chat>> getMessage({
    required String senderId,
    required String receiverId,
  });
}

class ChatMessageDatasourceImpl extends ChatMessageDatasource {
  final FirebaseConsumer firebaseConsumer;

  ChatMessageDatasourceImpl({required this.firebaseConsumer});
  @override
  Stream<List<Chat>> getMessage({
    required String senderId,
    required String receiverId,
  }) {
    return firebaseConsumer.getMessages(senderId: senderId, receiverId: receiverId);
  }

  @override
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String dateTime,
    required String message,
  }) async {
    await firebaseConsumer.sendMessages(
      senderId: senderId,
      receiverId: receiverId,
      dateTime: dateTime,
      message: message,
    );
  }
}
