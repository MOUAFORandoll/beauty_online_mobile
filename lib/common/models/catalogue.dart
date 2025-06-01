import 'package:beauty/common/models/realisation_file.dart';
import 'package:beauty/common/models/video.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:beauty/common/utils/datetime_converter.dart';
part 'catalogue.freezed.dart';
part 'catalogue.g.dart';

@freezed
class Catalogue with _$Catalogue {
  const Catalogue._();

  const factory Catalogue({
    required String id,
    required String title,
    String? price,
    @JsonKey(name: 'profile_professionnel_id')
    required String profileProfessionnelId,
    @JsonKey(name: 'realisation_files')
    required List<RealisationFile> realisationFiles,
    @JsonKey(name: 'is_video') bool? isVideo,
    @JsonKey(name: 'video') Video? video,
  }) = _Catalogue;

  factory Catalogue.fromJson(Map<String, dynamic> json) =>
      _$CatalogueFromJson(json);
}
