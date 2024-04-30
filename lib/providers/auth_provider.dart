import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jeeni/Apis/network_manager.dart';
import 'package:jeeni/models/student.dart';
import 'package:jeeni/utils/local_data_manager.dart';

enum AuthenticationState {
  loading,
  loggedIn,
  loggedOut,
}

final authenticationProvider =
    StateNotifierProvider<AuthenticationNotifier, Student>((ref) {
  return AuthenticationNotifier();
});

class SharedPreferencesKeys {
  static const String token = "TOKEN";
  static const String refreshToken = "REFRESHTOKEN";
  static const String userId = "USERID";
  static const String role = "ROLE";
  static const String orgId = "ORGANIZATIONID";
  static const String userName = "USERNAME";
  static const String language = "LANGUAGE";
}

class AuthenticationNotifier extends StateNotifier<Student> {
  AuthenticationNotifier()
      : super(
          Student.init(
            authenticationState: AuthenticationState.loading,
          ),
        ) {
    _loadUser();
  }

  void _loadUser() async {
    Future.delayed(
      const Duration(seconds: 0),
      () async {
        await LocalDataManager().loadStudentFromLocal().then((student) {
          log("AUTH :: ${student.jauth}");
          state = student.copyWith(
              authenticationState: AuthenticationState.loggedIn);
        }).catchError((error) {
          log("AUTH ERROR :: $error");
        });
      },
    );
  }

  Future<void> logOut() async {
    final isCleared = await LocalDataManager().clearLocalDatabase();
    if (isCleared) {
      state = state.copyWith(
          jauth: null, authenticationState: AuthenticationState.loggedOut);
    }
  }

  Future<void> loginWithIdAndPassword({
    required String userId,
    required String password,
    required String deviceIMEI,
  }) async {
    NetworkManager()
        .loginWithIdAndPassword(
            userId: userId, password: password, deviceIMEI: deviceIMEI)
        .then((student) {
      LocalDataManager().storeStudent(student);
      state =
          student.copyWith(authenticationState: AuthenticationState.loggedIn);
    }).catchError((error) {
      throw Exception("Invalid User");
      //TODO :
    });
  }
}
