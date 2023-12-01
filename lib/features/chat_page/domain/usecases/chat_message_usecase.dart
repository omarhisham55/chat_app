import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/features/chat_page/domain/entities/chat.dart';
import 'package:chat_app/features/chat_page/domain/repositories/chat_messages_repository.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

class SendChatMessagesUseCase extends UseCase<void, List<String>> {
  final ChatMessagesRepository chatMessagesReopsitory;

  SendChatMessagesUseCase({required this.chatMessagesReopsitory});
  @override
  Future<Either<Failure, void>> call(List<String> params) =>
      chatMessagesReopsitory.sendMessage(
        senderId: params[0],
        receiverId: params[1],
        dateTime: params[2],
        message: params[3],
      );
}

class GetChatMessagesUseCase extends UseCase<Stream<List<Chat>>, List<String>> {
  final ChatMessagesRepository chatMessagesRepository;

  GetChatMessagesUseCase({required this.chatMessagesRepository});
  @override
  Future<Either<Failure, Stream<List<Chat>>>> call(List<String> params) =>
      chatMessagesRepository.getMessages(
        senderId: params[0],
        receiverId: params[1],
      );
}

class AddToArchiveUsecase extends UseCase<Future<bool>, List<User>> {
  final ChatMessagesRepository chatMessagesRepository;

  AddToArchiveUsecase({required this.chatMessagesRepository});
  @override
  Future<Either<Failure, Future<bool>>> call(List<User> params) async {
    return await chatMessagesRepository.addToArchive(archivedUsers: params);
  }
}
