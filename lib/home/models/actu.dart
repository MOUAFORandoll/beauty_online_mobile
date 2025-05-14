import 'package:beauty/Professional/models/catalogue.dart';
import 'package:beauty/Professional/models/professional.dart';
import 'package:freezed_annotation/freezed_annotation.dart'; 
part 'actu.freezed.dart';
part 'actu.g.dart';

@freezed
class Actu with _$Actu {
  const factory Actu({
    required String id,
    required String title,
    required String price,
    @JsonKey(name: 'profile_professionnel')
    required Professional profileProfessionnel,
    @JsonKey(name: 'r,ealisation_files')
    required List<RealisationFile> realisationFiles,
  }) = _Actu;

  factory Actu.fromJson(Map<String, dynamic> json) => _$ActuFromJson(json);
}
