import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:beauty/common/models/catalogue.dart'; 
import 'package:firebase_auth/firebase_auth.dart'
    show AuthCredential, FirebaseAuth, GoogleAuthProvider, OAuthProvider;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart' hide PreferencesService, ApiError;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:beauty/common/services/api_error.dart';
import 'package:beauty/common/services/preferences_service.dart';

part 'catalogue_state.dart';

class CatalogueCubit extends ObjectCubit<Catalogue, CatalogueState> {
 
  CatalogueCubit(Catalogue catalogue)
      : super(const InitializingCatalogueState()) {
    emit(CatalogueLoadedState(catalogue));
  }

  @override
  Catalogue? getObject(CatalogueState state) {
    if (state is CatalogueLoadedState) {
      return state.catalogue;
    }
    return null;
  }

  Catalogue get catalogue {
    final Catalogue = getObject(state) ?? object;

    if (Catalogue != null) return Catalogue;
    throw UnsupportedError(
        'cannot retrieve Catalogue when not logged: Current state is ${state.runtimeType}');
  }
   
  @override
  void update(Catalogue object) {
    emit(CatalogueLoadedState(object));

    // TODO: implement update
  }
}
