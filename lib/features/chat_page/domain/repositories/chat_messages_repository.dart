import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/features/chat_page/domain/entities/chat.dart';
import 'package:dartz/dartz.dart';

abstract class ChatMessagesReopsitory {
  Future<Either<Failure, void>> sendMessage({
    required String senderId,
    required String receiverId,
    required String dateTime,
    required String message,
  });
  Future<Either<Failure, List<Chat>>> getMessages({
    required String senderId,
    required String receiverId,
  });
}