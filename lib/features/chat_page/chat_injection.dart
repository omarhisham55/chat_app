import 'package:chat_app/features/chat_page/data/datasources/chat_message_datasource.dart';
import 'package:chat_app/features/chat_page/data/repositories/chat_message_repository_impl.dart';
import 'package:chat_app/features/chat_page/domain/repositories/chat_messages_repository.dart';
import 'package:chat_app/features/chat_page/domain/usecases/chat_message_usecase.dart';
import 'package:chat_app/features/chat_page/presentation/cubit/chat_page_cubit.dart';
import 'package:chat_app/injection_container.dart';

Future<void> chatInjection() async {
  //cubit
  injection.registerFactory(
    () => ChatPageCubit(chatMessagesUseCase: injection()),
  );
  //datasource
  injection.registerLazySingleton<ChatMessageDatasource>(
    () => ChatMessageDatasourceImpl(firebaseConsumer: injection()),
  );
  //repository
  injection.registerLazySingleton<ChatMessagesReopsitory>(
    () => ChatMessagesReopsitoryImpl(
      network: injection(),
      chatMessageDatasource: injection(),
    ),
  );
  //usecase
  injection.registerLazySingleton(
    () => ChatMessagesUseCase(chatMessagesReopsitory: injection()),
  );
}
