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
  }) = _Catalogue;

  factory Catalogue.fromJson(Map<String, dynamic> json) =>
      _$CatalogueFromJson(json);
}

@freezed
class RealisationFile with _$RealisationFile {
  const RealisationFile._();

  const factory RealisationFile({
    required String id,
    @JsonKey(name: 'file_path') required String filePath,
  }) = _RealisationFile;

  factory RealisationFile.fromJson(Map<String, dynamic> json) =>
      _$RealisationFileFromJson(json);
}
