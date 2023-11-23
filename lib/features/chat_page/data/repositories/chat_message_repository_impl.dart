import 'package:chat_app/core/error/exception.dart';
import 'package:chat_app/core/error/failure.dart';
import 'package:chat_app/core/network/network_info.dart';
import 'package:chat_app/core/utils/constants.dart';
import 'package:chat_app/features/chat_page/data/datasources/chat_message_datasource.dart';
import 'package:chat_app/features/chat_page/domain/entities/chat.dart';
import 'package:chat_app/features/chat_page/domain/repositories/chat_messages_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ChatMessagesReopsitoryImpl implements ChatMessagesRepository {
  final NetworkInfo network;
  final ChatMessageDatasource chatMessageDatasource;

  ChatMessagesReopsitoryImpl({
    required this.network,
    required this.chatMessageDatasource,
  });
  @override
  Future<Either<Failure, Stream<List<Chat>>>> getMessages({
    required String senderId,
    required String receiverId,
  }) async {
    if (await network.isConnected) {
      try {
        return Right(
          chatMessageDatasource.getMessage(
            senderId: senderId,
            receiverId: receiverId,
          ),
        );
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      Constants.showToast(msg: "network error", color: Colors.red);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String senderId,
    required String receiverId,
    required String dateTime,
    required String message,
  }) async {
    if (await network.isConnected) {
      try {
        return Right(
          await chatMessageDatasource.sendMessage(
            senderId: senderId,
            receiverId: receiverId,
            dateTime: dateTime,
            message: message,
          ),
        );
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
