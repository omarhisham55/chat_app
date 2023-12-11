import 'package:chat_app/core/firebase/firebase_consumer/firebase_consumer.dart';
import 'package:chat_app/features/registration/data/models/user_model.dart';
import 'package:chat_app/features/registration/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GetUserDatasource {
  Future<UserModel> getUser({
    required String email,
    required String password,
  });
  Future<bool> cachedUser(String id);
  Future<User?>? getCachedUser();
}

abstract class GetAllUsersDataSource {
  Future<List<User>> getAllUsers();
}

class GetUserDatasourceImpl implements GetUserDatasource {
  final FirebaseAuthConsumer firebaseConsumer;
  final SharedPreferences sharedPreferences;

  GetUserDatasourceImpl(
      {required this.firebaseConsumer, required this.sharedPreferences});

  @override
  Future<UserModel> getUser(
      {required String email, required String password}) async {
    return firebaseConsumer
        .loginWithEmailAndPassword(email: email, password: password)
        .then((value) => UserModel.fromJson(value.data()!));
  }

  @override
  Future<bool> cachedUser(String id) async {
    return await sharedPreferences.setString("userId", id);
  }

  @override
  Future<User?> getCachedUser() async {
    final String? response = sharedPreferences.containsKey("userId")
        ? sharedPreferences.getString("userId")
        : null;
    if (response != null) {
      final user = await firebaseConsumer.getLoggedInUser(response);
      return UserModel.fromJson(user.data()!);
    }
    return Future.value();
  }
}

class GetAllUsersDataSourceImp implements GetAllUsersDataSource {
  final FirebaseAuthConsumer firebaseConsumer;
  final SharedPreferences sharedPreferences;
  List<UserModel> users = [];

  GetAllUsersDataSourceImp({
    required this.firebaseConsumer,
    required this.sharedPreferences,
  });

  @override
  Future<List<UserModel>> getAllUsers() async {
    final response = await firebaseConsumer.getAllUsers();
    for (var element in response.docs) {
      if (element.data()["id"] != sharedPreferences.getString("userId")) {
        users.add(UserModel.fromJson(element.data()));
      }
    }
    return users;
  }
}
