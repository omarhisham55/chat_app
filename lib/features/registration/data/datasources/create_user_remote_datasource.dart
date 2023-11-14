import 'package:chat_app/core/firebase/firebase_consumer/firebase_consumer.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CreateUserRemoteDataSource {
  Future<UserCredential> createUserByEmail({
    required String username,
    required String email,
    required String password,
  });
  Future<void> createUserByPhoneNumber({required String phoneNumber});
  Future sendSmsCode({required String smsCode});
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
  Future<void> createUserByPhoneNumber({required String phoneNumber}) async {
    await firebaseConsumer.phoneNumberAuthentication(phoneNumber: phoneNumber);
  }

  @override
  Future sendSmsCode({required String smsCode}) async {
    await firebaseConsumer.sendSmsCode(smsCode: smsCode);
  }
}
