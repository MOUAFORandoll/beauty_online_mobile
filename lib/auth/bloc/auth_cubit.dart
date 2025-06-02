import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:beauty/auth/services/auth_service.dart';
import 'package:beauty/common/bloc/user_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserCubit userCubit;
  final AuthService authService;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthCubit(this.userCubit, this.authService) : super(AuthIdleState());

  void googleSignIn() async {
    if (state is! AuthIdleState) return;
    final stateBefore = state;

    try {
      await _googleSignIn.signOut();
      final account = await _googleSignIn.signIn();
      if (account == null) return;

      // emit(const AuthLoadingState());
      final authentication = await account.authentication;
      await FirebaseAuth.instance.signInWithCredential(
          GoogleAuthProvider.credential(
              accessToken: authentication.accessToken,
              idToken: authentication.idToken));
      _socialLogin();
    } catch (error, trace) {
      emit(AuthErrorState(error, trace));
      emit(stateBefore);
    }
  }

  void appleSignIn() async {
    if (!Platform.isIOS) return;
    if (state is! AuthIdleState) return;
    final stateBefore = state;

    try {
      final authentication =
          await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);

      if (authentication.identityToken == null) return;
      // emit(const AuthLoadingState());
      await FirebaseAuth.instance.signInWithCredential(
          OAuthProvider('apple.com').credential(
              idToken: authentication.identityToken,
              accessToken: authentication.authorizationCode));
      _socialLogin();
    } catch (error, trace) {
      emit(AuthErrorState(error, trace));
      emit(stateBefore);
    }
  }

  void _socialLogin() async {
    emit(const AuthLoadingState());

    final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    
    authService
        .authUser(
      token: idToken!,
    )
        .then((response) async {
      await userCubit.preferencesService.saveUser(response.user);
      await userCubit.preferencesService.saveAuthToken(idToken);
      userCubit.reset();
      if (response.user.phone == null || response.user.userName == null) {
        emit(const NoCompletedUserState());
      } else {
        emit(const CompletedUserSuccessUserState());
      }
      emit(AuthIdleState());
    }, onError: (error, trace) {
      emit(AuthErrorState(error, trace));
      emit(AuthIdleState());
    });
  }

  void completeUserName({
    required String userName,
    required String countryCode,
    required String phone,
    required String codePhone,
  }) async {
    final stateBefore = state;

    emit(const AuthLoadingState());

    await authService
        .completeUserProfile(
            userName: userName,
            phone: phone,
            countryCode: countryCode,
            codePhone: codePhone)
        .then((user) {
      userCubit.preferencesService.saveUser(user).then((_) {
        emit(const CompletedUserSuccessUserState());
        emit(AuthIdleState());
        userCubit.reset();
      });
    }, onError: (error, trace) {
      emit(AuthErrorState(error, trace));
      emit(stateBefore);
    });
  }
}
