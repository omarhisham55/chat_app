import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/features/chat_page/domain/repositories/chat_messages_repository.dart';
import 'package:dartz/dartz.dart';

class ChatMessagesUseCase extends UseCase<void, List<String>> {
  final ChatMessagesReopsitory chatMessagesReopsitory;

  ChatMessagesUseCase({required this.chatMessagesReopsitory});
  @override
  Future<Either<Failure, void>> call(List<String> params) =>
      chatMessagesReopsitory.sendMessage(
        senderId: params[0],
        receiverId: params[1],
        dateTime: params[2],
        message: params[3],
      );
}
