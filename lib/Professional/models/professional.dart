import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:beauty/utils/datetime_converter.dart';
part 'professional.freezed.dart';
part 'professional.g.dart';

@freezed
class Professional with _$Professional {
  const Professional._();

  const factory Professional({
    required String id,
    @JsonKey(name: 'name_pro') required String namePro,
    required String service,
    required Position position,
    @JsonKey(name: 'nombre_reservation') required int nombreReservation,
    @JsonKey(name: 'nombre_catalogue') required int nombreCatalogue,
    @JsonKey(name: 'nombre_actes') required int nombreActes,
  }) = _Professional;

  factory Professional.fromJson(Map<String, dynamic> json) =>
      _$ProfessionalFromJson(json);
}

@freezed
class Position with _$Position {
  const Position._();

  const factory Position({
    @JsonKey(name: 'title_emplacement') required String titleEmplacement,
    required double longitude,
    required double latitude,
    String? town,
    String? country,
  }) = _Position;

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);
}
