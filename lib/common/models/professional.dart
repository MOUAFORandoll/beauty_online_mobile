import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:beauty/common/utils/datetime_converter.dart';
part 'professional.freezed.dart';
part 'professional.g.dart';

@freezed
class Professional with _$Professional {
  const Professional._();

  const factory Professional({
    required String id,
    @JsonKey(name: 'name_pro') required String namePro,
    String? service,
    Position? position,
    String? cover,
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
    @JsonKey(name: 'title_emplacement')   String? titleEmplacement,
    String? longitude,
    String? latitude,
    String? town,
    String? country,
  }) = _Position;

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);
}
