import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:beauty/common/models/rendez_vous.dart';
import 'package:beauty/my_pro/models/schedule.dart';
import 'package:beauty/common/models/agenda.dart';
import 'package:beauty/my_pro/bloc/my_professional_cubit.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:convert';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart' hide PreferencesService;
part 'gestion_professional_state.dart';

class GestionProfessionalCubit extends Cubit<GestionProfessionalState> {
  final ProfessionalService professionalService;
  final MyProfessionalCubit myProfessionalCubit;

  GestionProfessionalCubit(
    this.professionalService,
    this.myProfessionalCubit,
  ) : super(const InitializingGestionProfessionalState());

  Future<void> addCatalogue({
    required String libelle,
    required String prix,
    required List<File> images,
  }) async {
    final stateBefore = state;

    var data = {'title': libelle, 'price': prix};
    emit(const AddCatalogueLoadingState());
    final FormData formData = FormData.fromMap(data);

    formData.files.addAll(images
        .map((image) =>
            MapEntry('images[]', MultipartFile.fromFileSync(image.path)))
        .toList());
    log(formData.toString());
    log(formData.files.toString());

    try {
      await professionalService
          .addCatalogue(
        data: formData,
      )
          .then((onValue) {
        myProfessionalCubit.updateCatalogueCount(1);
        emit(AddCatalogueSuccessState());
      }).catchError((handleError, _) {
        emit(GestionProfessionalErrorState(handleError, null));
        emit(stateBefore);
      });
    } catch (error, stackTrace) {
      emit(GestionProfessionalErrorState(error, stackTrace));
      emit(stateBefore);
    }
  }

  Future<void> deleteCatalogue({
    required id,
  }) async {
    final stateBefore = state;

    emit(const DeletingCatalogueLoadingState());
    try {
      await professionalService
          .deleteCatalogue(
        id: id,
      )
          .then((onValue) {
        myProfessionalCubit.updateCatalogueCount(-1);
        emit(DeletedCatalogueSuccessState());
        emit(stateBefore);
      }).onError((handleError, _) {
        emit(GestionProfessionalErrorState(handleError, null));

        emit(stateBefore);
      });
    } catch (error, stackTrace) {
      emit(GestionProfessionalErrorState(error, stackTrace));
      emit(stateBefore);
    }
  }

  Future<void> addAgenda({
    required Schedule schedule,
  }) async {
    final stateBefore = state;
    emit(const AddAgendaLoadingState());

    try {
      var data = {
        'day': schedule.date.toString().split(' ')[0],
        'creneaux': schedule.timeSlots
            .map((e) => {
                  'startTimeAvailable': e.startTime.formaTime(),
                  'endTimeAvailable': e.endTime.formaTime()
                })
            .toList(),
      };
      print(data);
      log('========${data}');

      await professionalService
          .addAgenda(
        data: data,
      )
          .then((agenda) {
        emit(AddAgendaSuccessState(agenda: agenda));
      }).catchError((handleError, _) {
        emit(GestionProfessionalErrorState(handleError, null));
        emit(stateBefore);
      });
    } catch (error, stackTrace) {
      emit(GestionProfessionalErrorState(error, stackTrace));
      emit(stateBefore);
    }
  }

  Future<void> deleteAgenda({
    required Agenda agenda,
  }) async {
    final stateBefore = state;

    emit(const DeletingAgendaLoadingState());
    try {
      await professionalService
          .deleteAgenda(
        idAgenda: agenda.id,
      )
          .then((onValue) {
        emit(DeletedAgendaSuccessState(agenda: agenda));
        emit(stateBefore);
      }).onError((handleError, _) {
        emit(GestionProfessionalErrorState(handleError, null));

        emit(stateBefore);
      });
    } catch (error, stackTrace) {
      emit(GestionProfessionalErrorState(error, stackTrace));
      emit(stateBefore);
    }
  }

  Future<void> addCreneau({
    required idAgenda,
    required String date,
    required List<File> creneaux,
  }) async {
    final stateBefore = state;

    var data = {'creneaux': creneaux};
    emit(const AddCreneauLoadingState());

    try {
      await professionalService
          .addCreneau(
        idAgenda: idAgenda,
        data: data,
      )
          .then((onValue) {
        emit(AddCreneauSuccessState());
      }).catchError((handleError, _) {
        emit(GestionProfessionalErrorState(handleError, null));
        emit(stateBefore);
      });
    } catch (error, stackTrace) {
      emit(GestionProfessionalErrorState(error, stackTrace));
      emit(stateBefore);
    }
  }

  Future<void> deleteCreneau({
    required creneau,
  }) async {
    final stateBefore = state;

    emit(const DeletingCreneauLoadingState());
    try {
      await professionalService
          .deleteCreneau(
        idCreneau: creneau.id,
      )
          .then((onValue) {
        emit(DeletedCreneauSuccessState());
        emit(stateBefore);
      }).onError((handleError, _) {
        emit(GestionProfessionalErrorState(handleError, null));

        emit(stateBefore);
      });
    } catch (error, stackTrace) {
      emit(GestionProfessionalErrorState(error, stackTrace));
      emit(stateBefore);
    }
  }

  Future<void> acceptRendezVous({
    required String idRendezVous,
  }) async {
    final stateBefore = state;
    emit(const AcceptRendezVousLoadingState());

    try {
     await professionalService
          .acceptRendezVous(
        idRendezVous: idRendezVous,
      )
          .then((rendezVous) {
        emit(AcceptRendezVousSuccessState(rendezVous: rendezVous));
      }).catchError((handleError, _) {
        emit(GestionProfessionalErrorState(handleError, null));
        emit(stateBefore);
      });
    } catch (error, stackTrace) {
      emit(GestionProfessionalErrorState(error, stackTrace));
      emit(stateBefore);
    }
  }

  Future<void> declineRendezVous({
    required String idRendezVous,
  }) async {
    final stateBefore = state;
    emit(const DeclineRendezVousLoadingState());

    try {
      var data = {};
      print(data);
      log('========${data}');

      await professionalService
          .declineRendezVous(
        idRendezVous: idRendezVous,
      )
          .then((rendezVous) {
        emit(DeclineRendezVousSuccessState(rendezVous: rendezVous));
      }).catchError((handleError, _) {
        emit(GestionProfessionalErrorState(handleError, null));
        emit(stateBefore);
      });
    } catch (error, stackTrace) {
      emit(GestionProfessionalErrorState(error, stackTrace));
      emit(stateBefore);
    }
  }
}
