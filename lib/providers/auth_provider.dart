import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:jeeni/apis/network_manager.dart';
import 'package:jeeni/models/student.dart';
import 'package:jeeni/pages/auth/login_page.dart';
import 'package:jeeni/pages/dashboard.dart';
import 'package:jeeni/pages/splash_page.dart';
import 'package:jeeni/utils/local_data_manager.dart';

enum AuthenticationState {
  loading,
  loggedIn,
  loggedOut,
  alreadyLogInPop,
  logoutPopUp;

  Widget getPage(AuthenticationState authenticationState) {
    switch (authenticationState) {
      case AuthenticationState.loading:
        return const SplashPage();
      case AuthenticationState.loggedIn:
        return Dashboard();
      case AuthenticationState.loggedOut:
        return const LoginPage();
      case AuthenticationState.logoutPopUp ||
            AuthenticationState.alreadyLogInPop:
        return Dashboard();
    }
  }
}

final authenticationProvider =
    StateNotifierProvider<AuthenticationNotifier, Student?>((ref) {
  return AuthenticationNotifier(ref);
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

class AuthenticationNotifier extends StateNotifier<Student?> {
  final Ref ref;
  AuthenticationNotifier(this.ref)
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
          print("JAUTH  ${student.jauth}");
          state = student.copyWith(
              authenticationState: AuthenticationState.loggedIn);
        }).catchError((error) {
          log("AUTH ERROR :: $error");
          state = null;
          // final student = Student(
          //     organizationVos: [],
          //     hideFunctionalityIds: [],
          //     image: [],
          //     authenticationState: AuthenticationState.loggedIn);
          // state = student.copyWith(
          //     authenticationState: AuthenticationState.loggedIn);
        });
      },
    );
  }

  Future<void> logOut() async {
    final isCleared = await LocalDataManager().clearLocalDatabase();
    if (isCleared) {
      state = state?.copyWith(
        authenticationState: AuthenticationState.loggedOut,
      );
    }
  }

  void logOutPopUp() {
    state = state?.copyWith(
      authenticationState: AuthenticationState.logoutPopUp,
    );
  }

  Future<Response> loginWithIdAndPassword({
    required String userId,
    required String password,
    required String deviceIMEI,
  }) async {

    final response = await ref.read(networkProvider.notifier).loginWithIdAndPassword(
      userId: userId,
      password: password,
      deviceIMEI: deviceIMEI,
    );

    if (response.statusCode == 200) {
      
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final Student student = Student.fromMap(jsonResponse);
      final hasStored = await LocalDataManager().storeStudent(student);

      print("JAUTH ${student.jauth}");
      state = student.copyWith(authenticationState: AuthenticationState.loggedIn);
      return response;
    } else if(response.statusCode == 401){
      return response;
    } else {
      print("response ${response.body}");
      return response;
    }

  }

  void updateAuthState(AuthenticationState authState) {
    state = state?.copyWith(
      authenticationState: authState,
    );
  }
}
