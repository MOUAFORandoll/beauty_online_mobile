import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:beauty/common/models/professional.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show AuthCredential, FirebaseAuth, GoogleAuthProvider, OAuthProvider;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart' hide PreferencesService, ApiError;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:beauty/common/services/api_error.dart';
import 'package:beauty/common/services/preferences_service.dart';

part 'my_professional_state.dart';

class MyProfessionalCubit
    extends ObjectCubit<Professional, MyProfessionalState> {
  final ProfessionalService professionalService;
  final PreferencesService preferencesService;

  MyProfessionalCubit(
    this.professionalService,
    this.preferencesService,
  ) : super(const InitializingMyProfessionalState()) {
    getInitialState();
    log('InitializingProfessionalStat===e');
    getInitialStateOnline();
  }

  @override
  Professional? getObject(MyProfessionalState state) {
    if (state is MyProfessionalLoggedState) {
      return state.professional;
    }
    return null;
  }

  void getInitialState() {
    final professional = preferencesService.professional;
    log('professional =======from store======================${professional}');
    if (professional != null) {
      emit(MyProfessionalLoggedState(professional));
    }
  }

  void updateCatalogueCount(int delta) {
    final professional = preferencesService.professional;
    if (professional != null) {
      final updatedProfessional = professional.copyWith(
        nombreCatalogue: professional.nombreCatalogue! + delta,
      );
      preferencesService.saveProfessional(updatedProfessional);
      emit(MyProfessionalLoggedState(updatedProfessional));
    }
  }

  void getInitialStateOnline() async {
    try {
      // emit(InitializingMyProfessionalState());
      print('proffff');
      await professionalService.findUserProfile().then((professional) {
        print(
          'proffvvvff===${professional}',
        );
        if (professional != null) {
          preferencesService.saveProfessional(professional);
          emit(MyProfessionalLoggedState(professional));
        } else {
          emit(NoProfessionnalFondState());
        }
      });
    } catch (e) {
      print(
        'proffdddddvvvff= ',
      );
      emit(NoProfessionnalFondState());
      try {
        if ((e as ApiError).error != null) {
          if ((e).error!.code == 'PROFILE_PRO_NOT_FOUND') {
            emit(NoProfessionnalFondState());
          } else {
            emit(MyProfessionalErrorState(e));
          }
        } else {
          emit(MyProfessionalErrorState(e));
        }
      } catch (e) {
        emit(MyProfessionalErrorState(e));
      }
    }
    ;
  }

  void updateProfilePicture({required File file}) {
    final stateBefore = state;

    emit(const MyProfessionalUpdatingState());
    professionalService.updateProfilePicture(file: file).then((professional) {
      preferencesService.saveProfessional(professional);
      emit(const MyProfessionalUpdatedState());
      emit(MyProfessionalLoggedState(professional));
    }, onError: (error, trace) {
      emit(UpdateMyProfessionalErrorState(error, trace));
      emit(stateBefore);
    });
  }

  void updateProfilePro({
    int? type,
    String? data,
  }) {
    final stateBefore = state;

    emit(const MyProfessionalUpdatingState());
    professionalService
        .updateProfilePro(
      type: type,
      data: data,
    )
        .then((professional) {
      preferencesService.saveProfessional(professional);
      emit(const MyProfessionalUpdatedState());
      emit(MyProfessionalLoggedState(professional));
    }, onError: (error, trace) {
      emit(UpdateMyProfessionalErrorState(error, trace));
      emit(stateBefore);
    });
  }

  Professional get professional {
    final professional = getObject(state) ?? object;

    if (professional != null) return professional;
    throw UnsupportedError(
        'cannot retrieve professional when not logged: Current state is ${state.runtimeType}');
  }

  void shareItem() {
    if (state is MyProfessionalLoggedState) {
      final stateBefore = state;

      emit(const ShareMyProfessionalLoadingState());
      professionalService
          .shareProfile(
        id: professional!.id,
      )
          .then((link) {
        emit(ShareMyProfessionalSuccessState(link));
        emit(MyProfessionalLoggedState(professional));
      }, onError: (error, trace) {
        emit(MyProfessionalErrorState(error, trace));
        emit(stateBefore);
      });
    }
  }

  @override
  void update(Professional object) {
    // TODO: implement update
  }
}
