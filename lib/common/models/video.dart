import 'package:freezed_annotation/freezed_annotation.dart';
part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class Video with _$Video {
  const factory Video({
    required String id,
    @JsonKey(name: 'video_link') required String videoLink,
    required String thumbnail,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}
