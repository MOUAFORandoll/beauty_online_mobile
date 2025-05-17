import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:beauty/common/bloc/select_realisation_cubit.dart';
import 'package:beauty/common/models/rendez_vous.dart';
import 'package:beauty/my_pro/models/schedule.dart';
import 'package:beauty/common/models/agenda.dart';
import 'package:beauty/my_pro/bloc/my_professional_cubit.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:beauty/professional/bloc/professional_cubit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:convert';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart' hide PreferencesService;
part 'action_professional_state.dart';

class ActionProfessionalCubit extends Cubit<ActionProfessionalState> {
  final ProfessionalService professionalService;
  final SelectRealisationCubit selectRealisationCubit;
  ActionProfessionalCubit(
    this.professionalService,
    this.selectRealisationCubit,
  ) : super(const InitializingActionProfessionalState());

  Future<void> newRendezVous({
    required String creneauId,
  }) async {
    final stateBefore = state;

    var data = {
      'creneau_id': creneauId,
      'realisation_id': selectRealisationCubit.state
    };
    emit(const NewRendezVousLoadingState());

    try {
      await professionalService
          .newRendezVous(
        data: data,
      )
          .then((onValue) {
        emit(NewRendezVousSuccessState(onValue));
      }).catchError((handleError, _) {
        emit(ActionProfessionalErrorState(handleError, null));
        emit(stateBefore);
      });
    } catch (error, stackTrace) {
      emit(ActionProfessionalErrorState(error, stackTrace));
      emit(stateBefore);
    }
  }

  Future<void> deleteRendezVous({
    required creneau,
  }) async {
    final stateBefore = state;

    emit(const DeletingRendezVousLoadingState());
    try {
      await professionalService
          .deleteRendezVous(
        idRendezVous: creneau.id,
      )
          .then((onValue) {
        emit(DeletedRendezVousSuccessState());
        emit(stateBefore);
      }).onError((handleError, _) {
        emit(ActionProfessionalErrorState(handleError, null));

        emit(stateBefore);
      });
    } catch (error, stackTrace) {
      emit(ActionProfessionalErrorState(error, stackTrace));
      emit(stateBefore);
    }
  }
}
