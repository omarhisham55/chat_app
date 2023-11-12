import 'package:chat_app/core/firebase/firebase_consumer/firebase_consumer.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CreateUserRemoteDataSource {
  Future<UserCredential> createUser({
    required String username,
    required String email,
    required String password,
  });
}

class CreateUserRemoteDataSourceImpl implements CreateUserRemoteDataSource {
  final FirebaseConsumer firebaseConsumer;

  CreateUserRemoteDataSourceImpl({required this.firebaseConsumer});
  @override
  Future<UserCredential> createUser({
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
}
