import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthentication {
  Future<UserCredential> emailAuthentication({
    required String username,
    required String email,
    required String password,
  });
  Future<void> phoneNumberAuthentication({required String phoneNumber});
  sendSmsCode({required String smsCode});
  Future<DocumentSnapshot<Map<String, dynamic>>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<DocumentSnapshot<Map<String, dynamic>>> getLoggedInUser(String id);
}
