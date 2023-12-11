import 'dart:io';

import 'package:chat_app/core/error/exception.dart';
import 'package:chat_app/core/firebase/firebase_auth/firebase_auth.dart';
import 'package:chat_app/core/firebase/firebase_auth/firebase_messaging.dart';
import 'package:chat_app/core/utils/constants.dart';
import 'package:chat_app/features/chat_page/data/models/chat_model.dart';
import 'package:chat_app/features/chat_page/domain/entities/chat.dart';
import 'package:chat_app/features/registration/data/models/user_model.dart';
import 'package:chat_app/features/splash_screen/presentation/cubit/splash_screen_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseAuthConsumer implements FirebaseAuthentication {
  final FirebaseAuth client;
  final FirebaseFirestore firebsaeData;

  const FirebaseAuthConsumer({
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
      return Future.error(_handleFirebaseAuthException(error));
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
      return Future.error(_handleFirebaseAuthException(error));
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
          _handleFirebaseAuthException(error);
          debugPrint("zaza ${error.code}");
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          _verifyId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return true;
    } on FirebaseAuthException catch (error) {
      _handleFirebaseAuthException(error);
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
    try {
      return await firebsaeData.collection("users").get();
    } on FirebaseException catch (error) {
      return Future.error(_handleFirebaseException(error));
    }
  }

  static dynamic _handleFirebaseException(FirebaseException error) {
    switch (error.code) {
      case "UNAVAILABLE":
        Constants.showToast(
          msg: const ConnectionError().msg!,
          color: Colors.red,
        );
        throw const ConnectionError();
      case "permission-denied":
        Constants.showToast(
          msg: const PermissionDenied().msg!,
          color: Colors.red,
        );
        throw const PermissionDenied();
    }
  }

  static dynamic _handleFirebaseAuthException(FirebaseAuthException error) {
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

class FirebaseConsumer implements FirebaseMessaging {
  final FirebaseFirestore firebaseFirestore;

  FirebaseConsumer({required this.firebaseFirestore});
  @override
  Future<void> sendMessages({
    required String senderId,
    required String receiverId,
    required String dateTime,
    required String message,
  }) async {
    try {
      final ChatModel model = ChatModel(
        senderId: senderId,
        receiverId: receiverId,
        dateTime: dateTime,
        message: message,
      );
      //set main user chat
      await firebaseFirestore
          .collection("users")
          .doc(senderId)
          .collection("chats")
          .doc(receiverId)
          .collection("messages")
          .add(model.toMap());
      //set other user chat
      await firebaseFirestore
          .collection("users")
          .doc(receiverId)
          .collection("chats")
          .doc(senderId)
          .collection("messages")
          .add(model.toMap());
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Stream<List<Chat>> getMessages({
    required String senderId,
    required String receiverId,
  }) {
    try {
      return firebaseFirestore
          .collection("users")
          .doc(senderId)
          .collection("chats")
          .doc(receiverId)
          .collection("messages")
          .orderBy("dateTime")
          .snapshots()
          .map(
            (querySnapshot) => querySnapshot.docs
                .map((doc) => ChatModel.fromJson(doc.data()))
                .toList(),
          );
    } on FirebaseException catch (error) {
      return FirebaseAuthConsumer._handleFirebaseException(error);
    }
  }

  @override
  Future<bool> removeChat({required removedUsers}) async {
    for (var user in removedUsers) {
      final List<Chat> models = await getMessages(
        senderId: SplashScreenCubit.userModel!.id,
        receiverId: user.id,
      ).last;
      for (var i = 0; i < models.length; i++) {
        firebaseFirestore
            .collection("users")
            .doc(SplashScreenCubit.userModel!.id)
            .collection("chats")
            .doc(user.id)
            .delete()
            .then((value) => true);
      }
    }
    return false;
  }

  bool tryT = false;
  @override
  Future<bool> addToArchive({required archivedUsers}) async {
    try {
      for (var user in archivedUsers) {
        final List<Chat> models = await getMessages(
          senderId: SplashScreenCubit.userModel!.id,
          receiverId: user.id,
        ).last;
        for (var i = 0; i < models.length; i++) {
          ChatModel chatModel = ChatModel(
            senderId: models[i].senderId,
            receiverId: models[i].receiverId,
            dateTime: models[i].dateTime,
            message: models[i].message,
          );
          await firebaseFirestore
              .collection("users")
              .doc(SplashScreenCubit.userModel!.id)
              .collection("archivedChat")
              .doc(user.id)
              .collection("archivedMessages")
              .add(chatModel.toMap())
              .then((value) => tryT = true);
        }
      }
      // await removeChat(removedUsers: archivedUsers);
      return tryT;
    } catch (error) {
      return false;
    }
  }
}

class FirebaseConsumerStorage implements FirebaseStore {
  final FirebaseStorage firebaseStorage;

  FirebaseConsumerStorage({required this.firebaseStorage});
  @override
  Future<UploadTask> storeProfileImage({required File file}) async {
    return firebaseStorage
        .ref()
        .child("users/${Uri.file(file.path).pathSegments.last}")
        .putFile(file);
  }
}
