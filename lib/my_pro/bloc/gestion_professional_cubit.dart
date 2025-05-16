import 'dart:async';
import 'dart:developer';
import 'dart:io';
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
    required String date,
    required List<File> creneaux,
  }) async {
    final stateBefore = state;

    var data = {'dates': date, 'creneaux': creneaux};
    emit(const AddAgendaLoadingState());

    try {
      await professionalService
          .addAgenda(
        data: data,
      )
          .then((onValue) {
        emit(AddAgendaSuccessState());
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
    required id,
  }) async {
    final stateBefore = state;

    emit(const DeletingAgendaLoadingState());
    try {
      await professionalService
          .deleteAgenda(
        id: id,
      )
          .then((onValue) {
        emit(DeletedAgendaSuccessState());
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
    required idCreneau,
  }) async {
    final stateBefore = state;

    emit(const DeletingCreneauLoadingState());
    try {
      await professionalService
          .deleteCreneau(
        idCreneau: idCreneau,
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
}
