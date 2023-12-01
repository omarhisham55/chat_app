import 'package:chat_app/core/firebase/firebase_consumer/firebase_consumer.dart';
import 'package:chat_app/features/chat_page/domain/entities/chat.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';

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
  Future<bool> addToArchive({required List<User> archivedUsers});
}

class ChatMessageDatasourceImpl extends ChatMessageDatasource {
  final FirebaseConsumer firebaseConsumer;

  ChatMessageDatasourceImpl({required this.firebaseConsumer});
  @override
  Stream<List<Chat>> getMessage({
    required String senderId,
    required String receiverId,
  }) {
    return firebaseConsumer.getMessages(
      senderId: senderId,
      receiverId: receiverId,
    );
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

  @override
  Future<bool> addToArchive({required List<User> archivedUsers}) async {
    return await firebaseConsumer.addToArchive(archivedUsers: archivedUsers);
  }
}
