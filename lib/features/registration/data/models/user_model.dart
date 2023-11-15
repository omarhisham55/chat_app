// ignore_for_file: overridden_fields

import 'package:chat_app/features/registration/domain/entities/user.dart';

class UserModel extends User {
  @override
  final String id;
  @override
  final String username;
  @override
  final String? email;
  @override
  final String? phoneNumber;

  const UserModel({
    required this.id,
    required this.username,
    this.email,
    this.phoneNumber,
  }) : super(
          id: id,
          username: username,
          email: email,
          phoneNumber: phoneNumber,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}
