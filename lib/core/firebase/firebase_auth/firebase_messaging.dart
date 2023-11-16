abstract class FirebaseMessaging {
  Future<void> sendMessages({
    required String senderId,
    required String receiverId,
    required String dateTime,
    required String message,
  });
  // Future<>
}
