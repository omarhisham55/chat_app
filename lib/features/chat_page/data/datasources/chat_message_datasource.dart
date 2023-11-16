import 'package:chat_app/core/firebase/firebase_consumer/firebase_consumer.dart';

abstract class ChatMessageDatasource {
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String dateTime,
    required String message,
  });
  Future<void> getMessage();
}

class ChatMessageDatasourceImpl extends ChatMessageDatasource {
  final FirebaseConsumer firebaseConsumer;

  ChatMessageDatasourceImpl({required this.firebaseConsumer});
  @override
  Future<void> getMessage() {
    // TODO: implement getMessage
    throw UnimplementedError();
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
