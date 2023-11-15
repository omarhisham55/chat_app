import 'package:chat_app/core/firebase/firebase_consumer/firebase_consumer.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CreateUserRemoteDataSource {
  Future<UserCredential> createUserByEmail({
    required String username,
    required String email,
    required String password,
  });
  Future<bool> createUserByPhoneNumber({required String phoneNumber});
  Future<UserCredential> sendSmsCode({required String smsCode});
}

class CreateUserRemoteDataSourceImpl implements CreateUserRemoteDataSource {
  final FirebaseConsumer firebaseConsumer;

  CreateUserRemoteDataSourceImpl({required this.firebaseConsumer});
  @override
  Future<UserCredential> createUserByEmail({
    required String username,
    required String email,
    required String password,
  }) async {
    return await firebaseConsumer.emailAuthentication(
      username: username,
      email: email,
      password: password,
    );
  }

  @override
  Future<bool> createUserByPhoneNumber({required String phoneNumber}) async {
    return await firebaseConsumer.phoneNumberAuthentication(phoneNumber: phoneNumber);
  }

  @override
  Future<UserCredential> sendSmsCode({required String smsCode}) async {
    return await firebaseConsumer.sendSmsCode(smsCode: smsCode);
  }
}
