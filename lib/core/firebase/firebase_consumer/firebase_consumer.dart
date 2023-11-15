import 'package:chat_app/core/error/exception.dart';
import 'package:chat_app/core/firebase/firebase_auth/firebase_auth.dart';
import 'package:chat_app/core/utils/constants.dart';
import 'package:chat_app/features/registration/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseConsumer implements FirebaseAuthentication {
  final FirebaseAuth client;
  final FirebaseFirestore firebsaeData;

  const FirebaseConsumer({
    required this.client,
    required this.firebsaeData,
  });

  @override
  Future<UserCredential> emailAuthentication({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final response = await client.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveCreatedUser(
        UserModel(
          id: response.user!.uid,
          username: username,
          email: email,
        ),
      );
      return response;
    } on FirebaseAuthException catch (error) {
      return Future.error(_handleFirebaseException(error));
    }
  }

  Future<void> _saveCreatedUser(UserModel userModel) async {
    await firebsaeData
        .collection("users")
        .doc(userModel.id)
        .set(userModel.toMap());
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getLoggedInUser(
          String id) async =>
      await firebsaeData.collection("users").doc(id).get();

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await client.signInWithEmailAndPassword(
          email: email, password: password);
      return getLoggedInUser(user.user!.uid);
    } on FirebaseAuthException catch (error) {
      return Future.error(_handleFirebaseException(error));
    }
  }

  static String? _verifyId;
  @override
  Future<bool> phoneNumberAuthentication({required String phoneNumber}) async {
    try {
      await client.verifyPhoneNumber(
        phoneNumber: "+2$phoneNumber",
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await client.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException error) {
          _handleFirebaseException(error);
          debugPrint("zaza ${error.code}");
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          _verifyId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return true;
    } on FirebaseAuthException catch (error) {
      _handleFirebaseException(error);
      debugPrint("hamo ${error.code}");
      return false;
    }
  }

  @override
  Future<UserCredential> sendSmsCode({required String smsCode}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verifyId!,
      smsCode: smsCode,
    );
    final response = await client.signInWithCredential(credential);
    await _saveCreatedUser(
      UserModel(
        id: response.user!.uid,
        username: response.user!.phoneNumber!,
        phoneNumber: response.user!.phoneNumber,
      ),
    );
    return response;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    return await firebsaeData.collection("users").get();
  }

  dynamic _handleFirebaseException(FirebaseAuthException error) {
    switch (error.code) {
      case "INVALID_LOGIN_CREDENTIALS":
        Constants.showToast(
          msg: const InvalidLoginCredentials().msg!,
          color: Colors.red,
        );
        throw const InvalidLoginCredentials();
      case "invalid-email":
        Constants.showToast(
          msg: const InvalidEmailFormat().msg!,
          color: Colors.red,
        );
        throw const InvalidEmailFormat();
      case "wrong-password":
        Constants.showToast(
          msg: const InvalidPassword().msg!,
          color: Colors.red,
        );
        throw const InvalidPassword();
      case "user-not-found":
        Constants.showToast(
          msg: const UserNotFound().msg!,
          color: Colors.red,
        );
        throw const UserNotFound();
      case "email-already-in-use":
        Constants.showToast(
          msg: const EmailInUse().msg!,
          color: Colors.red,
        );
        throw const EmailInUse();
      case "invalid-phone-number":
        Constants.showToast(
          msg: const InvalidPhoneNumber().msg!,
          color: Colors.red,
        );
      case "too-many-requests":
        Constants.showToast(
          msg: const TooManyRequests().msg!,
          color: Colors.red,
        );
      default:
        Constants.showToast(
          msg: UnknownError(error.code).msg!,
          color: Colors.red,
        );
        throw const UnknownError();
    }
  }
}
