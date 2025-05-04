import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:beauty/Professionnal/models/professional.dart';
import 'package:beauty/Professionnal/services/professional_service.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show AuthCredential, FirebaseAuth, GoogleAuthProvider, OAuthProvider;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart' hide PreferencesService, ApiError;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:beauty/common/services/api_error.dart';
import 'package:beauty/common/services/preferences_service.dart';

part 'professional_state.dart';

class ProfessionalCubit extends ObjectCubit<Professional, ProfessionalState> {
  final ProfessionalService professionalService;

  ProfessionalCubit(
    this.professionalService,
  ) : super(const InitializingProfessionalState()) {
    log('InitializingProfessionalState');

    getInitialState();
    log('InitializingProfessionalStat===e');
  }

  @override
  Professional? getObject(ProfessionalState state) {
    if (state is ProfessionalLoggedState) {
      return state.professional;
    }
    return null;
  }

  void getInitialState() {
    try {
      emit(InitializingProfessionalState());
      print('proffff');
      professionalService.findUserProfile().then((professional) {
        print(
          'proffvvvff===${professional}',
        );
        if (professional != null)
          emit(ProfessionalLoggedState(professional));
        else
          emit(NoProfessionnalFondState());
      });
    } catch (e) {
      print(e);
      emit(ProfessionalErrorState(e));
    }
    ;
  }

  Professional get professional {
    final professional = getObject(state) ?? object;

    if (professional != null) return professional;
    throw UnsupportedError(
        'cannot retrieve professional when not logged: Current state is ${state.runtimeType}');
  }

  @override
  void update(Professional object) {
    // TODO: implement update
  }
}
