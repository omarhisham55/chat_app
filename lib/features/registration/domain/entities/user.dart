import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String? email;
  final String? phoneNumber;

  const User({
    required this.id,
    required this.username,
    this.email,
    this.phoneNumber,
  });
  @override
  List<Object?> get props => [username, email, phoneNumber];
}
