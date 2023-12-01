import 'package:chat_app/features/chat_page/domain/entities/chat.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';

abstract class FirebaseMessaging {
  Future<void> sendMessages({
    required String senderId,
    required String receiverId,
    required String dateTime,
    required String message,
  });
  Stream<List<Chat>> getMessages({
    required String senderId,
    required String receiverId,
  });
  Future<bool> addToArchive({required List<User> archivedUsers});
  Future<bool> removeChat({required List<User> removedUsers});
}
