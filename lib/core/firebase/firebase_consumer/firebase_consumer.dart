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

  const FirebaseConsumer({required this.client, required this.firebsaeData});

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
    }
  }
}
