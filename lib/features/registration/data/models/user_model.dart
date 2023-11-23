import 'package:chat_app/features/registration/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    super.email,
    super.phoneNumber,
    super.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
        "phoneNumber": phoneNumber,
        "ProfileImage": profileImage,
      };
}
