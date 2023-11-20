part of 'chat_page_cubit.dart';

abstract class ChatPageState extends Equatable {
  const ChatPageState();

  @override
  List<Object> get props => [];
}

class ChatPageInitial extends ChatPageState {}

class SendChatSuccess extends ChatPageState {
  final String msg;
  const SendChatSuccess(this.msg);

  @override
  List<Object> get props => [msg];
}

class SendChatFailed extends ChatPageState {
  final String msg;
  const SendChatFailed({this.msg = "message failed to send"});

  @override
  List<Object> get props => [msg];
}

class GetChatSuccess extends ChatPageState {
  final int msg;
  const GetChatSuccess(this.msg);

  @override
  List<Object> get props => [msg];
}

class GetChatFailed extends ChatPageState {
  final String msg;
  const GetChatFailed({this.msg = "message failed to receive"});

  @override
  List<Object> get props => [msg];
}
