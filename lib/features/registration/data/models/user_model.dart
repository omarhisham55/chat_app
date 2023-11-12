// ignore_for_file: overridden_fields

import 'package:chat_app/features/registration/domain/entities/user.dart';

class UserModel extends User {
  @override
  final String id;
  @override
  final String username;
  @override
  final String email;

  const UserModel({
    required this.id,
    required this.username,
    required this.email,
  }) : super(id: id, username: username, email: email);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
      };
}
