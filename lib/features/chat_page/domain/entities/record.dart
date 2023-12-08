import 'dart:io';

import 'package:equatable/equatable.dart';

class Record extends Equatable {
  final String senderId;
  final String receiverId;
  final String dateTime;
  final File message;

  const Record({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.message,
  });

  @override
  List<Object?> get props => [dateTime, message];
}
