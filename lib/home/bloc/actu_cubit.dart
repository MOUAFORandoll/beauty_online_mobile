import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/services/actu_service.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show AuthCredential, FirebaseAuth, GoogleAuthProvider, OAuthProvider;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart' hide PreferencesService, ApiError;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:beauty/common/services/api_error.dart';
import 'package:beauty/common/services/preferences_service.dart';

part 'actu_state.dart';

class ActuCubit extends ObjectCubit<Actu, ActuState> {
  final ActuService actuService;

  ActuCubit(this.actuService, Actu actu)
      : super(const InitializingActuState()) {
    emit(ActuLoadedState(actu));
  }

  @override
  Actu? getObject(ActuState state) {
    if (state is ActuLoadedState) {
      return state.actu;
    }
    return null;
  }

  Actu get actu {
    final actu = getObject(state) ?? object;

    if (actu != null) return actu;
    throw UnsupportedError(
        'cannot retrieve actu when not logged: Current state is ${state.runtimeType}');
  }

  void shareActu() {
    if (state is ActuLoadedState) {
      final stateBefore = state;

      emit(const ShareActuLoadingState());
      actuService
          .shareActu(
        id: actu!.id,
      )
          .then((link) {
        emit(ShareActuSuccessState(link));
        final newItem = actu.copyWith(nombrePartages: actu.nombrePartages + 1);
        update(newItem);
      }, onError: (error, trace) {
        emit(ActuErrorState(error, trace));
        emit(stateBefore);
      });
    }
  }

  void likeActu() {
    if (state is ActuLoadedState) {
      final stateBefore = state;
      emit(const LikeActuLoadingState());

      final newItem = actu.copyWith(
          hasLiked: !actu.hasLiked,
          nombreLikes:
              !actu.hasLiked ? actu.nombreLikes + 1 : actu.nombreLikes + 1);
      update(newItem);
      actuService
          .likeUnlikeActu(
        id: actu.id,
      )
          .then((link) {}, onError: (error, trace) {
        emit(ActuErrorState(error, trace));
        emit(stateBefore);
      });
    }
  }

  void vueActu() {
    if (state is ActuLoadedState) {
      emit(const VueActuLoadingState());
      final newItem = actu.copyWith(nombreVues: actu.nombreVues + 1);
      print(newItem.toJson());
      update(newItem);
      actuService
          .vueActu(
            id: actu.id,
          )
          .then((link) {}, onError: (error, trace) {});
    }
  }

  @override
  void update(Actu object) {
    emit(ActuLoadedState(object));

    // TODO: implement update
  }
}
