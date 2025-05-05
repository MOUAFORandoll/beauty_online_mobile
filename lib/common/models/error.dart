import 'package:freezed_annotation/freezed_annotation.dart';

part 'error.freezed.dart';
part 'error.g.dart';

@freezed
class Error with _$Error {
  const factory Error({
    required String code,
    @JsonKey(name: 'display_messages') List<IDisplayText>? displayMessages,
    required String url,
  }) = _Error;

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
}

@freezed
class IDisplayText with _$IDisplayText {
  const factory IDisplayText({
    required String lang,
    required dynamic value,
  }) = _IDisplayText;

  factory IDisplayText.fromJson(Map<String, dynamic> json) =>
      _$IDisplayTextFromJson(json);
}
