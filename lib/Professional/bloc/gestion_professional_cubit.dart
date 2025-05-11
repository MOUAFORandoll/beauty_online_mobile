import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:beauty/Professional/bloc/professional_cubit.dart';
import 'package:beauty/Professional/services/professional_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:convert';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart' hide PreferencesService;
part 'gestion_professional_state.dart';

class GestionProfessionalCubit extends Cubit<GestionProfessionalState> {
  final ProfessionalService professionalService;
  final ProfessionalCubit myProfessionalCubit;

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

    var data = {'title': libelle, 'prix': prix};
    log(data.toString());
    emit(const AddCatalogueLoadingState());
    final FormData formData = FormData.fromMap(data);
    // formData.files = {
    //   'images': images
    //       .map((image) =>
    //           MapEntry('images[]', MultipartFile.fromFileSync(image.path)))
    //       .toList()
    // };

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
        print(onValue);
        print("=================================onValue");
        emit(AddCatalogueSuccessState());
      }).catchError((handleError, _) {
        print('============error=====${handleError}');
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
}
