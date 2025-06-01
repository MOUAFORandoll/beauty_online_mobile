import 'package:beauty/common/models/video.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:beauty/common/utils/datetime_converter.dart';

part 'realisation_file.freezed.dart';
part 'realisation_file.g.dart';

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
