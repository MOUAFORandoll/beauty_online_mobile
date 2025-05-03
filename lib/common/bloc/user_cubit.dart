import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart'
    show AuthCredential, FirebaseAuth, GoogleAuthProvider, OAuthProvider;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart' hide PreferencesService, ApiError;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:beauty/common/models/user.dart';
import 'package:beauty/common/services/api_error.dart';
import 'package:beauty/common/services/preferences_service.dart';
import 'package:beauty/common/services/user_service.dart';

part 'user_state.dart';

class UserCubit extends ObjectCubit<User, UserState> {
  final UserService userService;
  final PreferencesService preferencesService;
  UserCubit(
    this.userService,
    this.preferencesService,
  ) : super(const InitializingUserState()) {
    _getInitialState(true);
  }

  @override
  User? getObject(UserState state) {
    if (state is UserLoggedState) {
      return state.user;
    }
    return null;
  }

  void _getInitialState([bool refresh = false]) {
    final user = preferencesService.user;

    if (user == null) {
      emit(const UserNotLoggedState());
    } else {
      if (refresh) _refreshData();
      if (user.phone == null) {
        emit(const CompleteUserProfileState());
      } else {
        emit(UserLoggedState(user));
      }
    }
  }

  void reset([bool refresh = false]) {
    _getInitialState(refresh);
  }

  void refreshData() {
    _getInitialState(true);
  }

  User get user {
    final user = getObject(state) ?? object;

    if (user != null) return user;
    throw UnsupportedError(
        'cannot retrieve user when not logged: Current state is ${state.runtimeType}');
  }

  Future<void> _refreshData() {
    return userService.getMe().then((user) => preferencesService.saveUser(user),
        onError: (error, trace) {
      if (error is ApiError) {
        if (error.dio?.error is InvalidAuthenticationHeadersException) {
          // si pour une raison obscure on arrive pas à générer les headers d'authentification
          signOut();
        } else if (error.error?.code == "USER_APP_UPGRADE") {
          final stateBefore = state;
          emit(const UserShouldUpgradeAppState());
          emit(stateBefore);
        }
      }
    });
  }

  void shareUser() {
    final stateBefore = state;

    emit(const ShareUserLoadingState());
    userService.shareUser(idUser: user.id).then((link) {
      emit(ShareUserSuccessState(link));
      emit(UserLoggedState(user));
    }, onError: (error, trace) {
      emit(UserErrorState(error, trace));
      emit(stateBefore);
    });
  }

  void updateUser({
    String? username,
    String? biography,
    List<String>? genres,
  }) {
    final stateBefore = state;

    emit(const UserUpdatingState());
    userService
        .updateUser(
      username: username,
      biography: biography,
      genres: genres,
    )
        .then((user) {
      preferencesService.saveUser(user);
      emit(const UserUpdatedState());
      emit(UserLoggedState(user));
    }, onError: (error, trace) {
      emit(UserErrorState(error, trace));
      emit(stateBefore);
    });
  }

  void updateProfilePicture({required File file}) {
    final stateBefore = state;

    emit(const UserUpdatingState());
    userService.updateProfilePicture(file: file).then((user) {
      preferencesService.saveUser(user);
      emit(const UserUpdatedState());
      emit(UserLoggedState(user));
    }, onError: (error, trace) {
      emit(UserErrorState(error, trace));
      emit(stateBefore);
    });
  }

  void signOut() {
    if (state is UserLoggedState) {
      final stateBefore = state;
      emit(const UserLoggingOut());
      unawaited(userService.logout());
      _removeAccount(stateBefore);
    }
  }

  void deleteAccount() async {
    if (state is UserLoggedState) {
      final stateBefore = state;

      try {
        final AuthCredential credential;
        if (Platform.isAndroid) {
          final account = await GoogleSignIn().signIn();
          if (account == null) return;
          final authentication = await account.authentication;

          credential = GoogleAuthProvider.credential(
              accessToken: authentication.accessToken,
              idToken: authentication.idToken);
        } else if (Platform.isIOS) {
          final authentication = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );

          credential = OAuthProvider('apple.com').credential(
              idToken: authentication.identityToken,
              accessToken: authentication.authorizationCode);
        } else {
          return;
        }

        await FirebaseAuth.instance.currentUser
            ?.reauthenticateWithCredential(credential);

        emit(const UserDeleting());
        userService
            .deleteAccount(FirebaseAuth.instance.currentUser!.uid)
            .then((_) => _removeAccount(stateBefore), onError: (error, trace) {
          emit(UserErrorState(error, trace));
          emit(stateBefore);
        });
      } catch (ignored) {/**/}
    }
  }

  void _removeAccount(UserState stateBefore) {
    Future.wait([
      GoogleSignIn().signOut(),
      FirebaseAuth.instance.signOut(),
      preferencesService.clear(),
      Future.delayed(const Duration(seconds: 2))
    ]).then((value) => emit(const UserNotLoggedState()),
        onError: (error, trace) {
      emit(UserErrorState(error, trace));
      emit(stateBefore);
    });
  }

  @override
  void update(User object) {
    // TODO: implement update
  }
}

class InvalidAuthenticationHeadersException implements Exception {
  const InvalidAuthenticationHeadersException();
}
