import 'dart:async';
import 'dart:io';

import 'package:beauty/Professional/bloc/professional_cubit.dart';
import 'package:beauty/common/models/professional.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart' hide PreferencesService;

part 'new_professional_state.dart';

class NewProfessionalCubit extends Cubit<NewProfessionalState> {
  final ProfessionalService professionalService;
  final ProfessionalCubit professionalCubit;

  NewProfessionalCubit(this.professionalService, this.professionalCubit)
      : super(const NewProfessionalIdleState());

  void create(
      {required String namePro,
      required String service,
      required String description,
      required double longitude,
      required double latitude,
      required String titleEmplacement,
      required XFile? image}) {
    print(state);
    emit(const NewProfessionalUploadingState());
    var data = {
      "namePro": namePro,
      "service": service,
      "description": description,
      "longitude": longitude,
      "latitude": latitude,
      "titleEmplacement": titleEmplacement,
    };
    professionalService.createUserProfile(data: data, cover: image).then(
        (profil) {
      professionalCubit.getInitialState();
      emit(NewProfessionalUploadedState(profil));
      Timer(const Duration(seconds: 5), () {
        emit(const NewProfessionalIdleState());
      });
    }, onError: (error, trace) {
      emit(NewProfessionalErrorState(error, trace));

      emit(const NewProfessionalIdleState());
    });
  }

  setMedia(File? file, AssetType? assetType) {
    emit(NewProfessionalMediaState(file: file, assetType: assetType));
  }
}
