part of 'chat_page_cubit.dart';

abstract class ChatPageState extends Equatable {
  const ChatPageState();

  @override
  List<Object?> get props => [];
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
  final int? msgL;
  final String? msg;
  const GetChatSuccess({this.msgL, this.msg});

  @override
  List<Object?> get props => [msgL ?? msg];
}

class GetChatFailed extends ChatPageState {
  final String msg;
  const GetChatFailed({this.msg = "message failed to receive"});

  @override
  List<Object> get props => [msg];
}

class AddToArchiveSuccess extends ChatPageState {
  final bool msg;
  const AddToArchiveSuccess(this.msg);

  @override
  List<Object> get props => [msg];
}

class AddToArchiveFailed extends ChatPageState {
  final String msg;
  const AddToArchiveFailed({this.msg = "users failed to archive"});

  @override
  List<Object> get props => [msg];
}

class SelectedChatState extends ChatPageState {
  final int list;
  const SelectedChatState({required this.list});

  @override
  List<Object> get props => [list];
}

class OnPlayerStateChanged extends ChatPageState {
  final PlayerState playerState;

  const OnPlayerStateChanged({required this.playerState});

  @override
  List<Object> get props => [playerState];
}

class OnDurationChanged extends ChatPageState {
  final Duration duration;

  const OnDurationChanged({required this.duration});

  @override
  List<Object> get props => [duration];
}

class OnPositionChanged extends ChatPageState {
  final Duration position;

  const OnPositionChanged({required this.position});

  @override
  List<Object> get props => [position];
}
