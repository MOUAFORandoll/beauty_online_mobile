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

part 'professional_state.dart';

class ProfessionalCubit extends ObjectCubit<Professional, ProfessionalState> {
  final ProfessionalService professionalService;
  final PreferencesService preferencesService;

  ProfessionalCubit(this.professionalService, this.preferencesService,
      Professional professional)
      : super(const InitializingProfessionalState()) {
    emit(ProfessionalLoadedState(professional));
   
  }

  @override
  Professional? getObject(ProfessionalState state) {
    if (state is ProfessionalLoadedState) {
      return state.professional;
    }
    return null;
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
