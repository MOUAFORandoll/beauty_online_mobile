import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:potatoes/common/bloc/cubit_manager.dart';
import 'package:beauty/professional/bloc/professional_cubit.dart';
import 'package:beauty/common/models/professional.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';

import 'package:potatoes/potatoes.dart' hide PreferencesService, ApiError;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:beauty/common/services/api_error.dart';
import 'package:beauty/common/services/preferences_service.dart'; 

class ProfessionalCubitManager
    extends CubitManager<ProfessionalCubit, Professional, String> {
  final ProfessionalService professionalService;
  final PreferencesService preferencesService;
  ProfessionalCubitManager(this.professionalService, this.preferencesService);

  @override
  String buildId(Professional object) {
    return object.id;
  }

  @override
  ProfessionalCubit create(Professional object) {
    return ProfessionalCubit(professionalService, preferencesService, object);
  }

  @override
  void updateCubit(ProfessionalCubit cubit, Professional object) {
    cubit.update(object);
  }
}
