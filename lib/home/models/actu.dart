import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/models/professional.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'actu.freezed.dart';
part 'actu.g.dart';

@freezed
class Actu with _$Actu {
  const factory Actu({
    required String id,
    required String title,
    String? price,
    @JsonKey(name: 'profile_professionnel')
    required Professional profileProfessionnel,
    @JsonKey(name: 'realisation_files')
    required List<RealisationFile> realisationFiles,
    @JsonKey(name: 'nombre_vues') required int nombreVues,
    @JsonKey(name: 'nombre_likes') required int nombreLikes,
    @JsonKey(name: 'has_liked') required bool hasLiked,
    @JsonKey(name: 'is_video') bool? isVideo,
    @JsonKey(name: 'video_link') String? videoLink,
    @JsonKey(name: 'nombre_partages') required int nombrePartages,
  }) = _Actu;

  factory Actu.fromJson(Map<String, dynamic> json) => _$ActuFromJson(json);
}
