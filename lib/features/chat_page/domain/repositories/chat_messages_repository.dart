import 'package:chat_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ChatMessagesReopsitory {
  Future<Either<Failure, void>> sendMessage({
    required String senderId,
    required String receiverId,
    required String dateTime,
    required String message,
  });
  Future<Either<Failure, void>> getMessages();
}