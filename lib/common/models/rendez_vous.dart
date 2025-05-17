import 'package:beauty/common/models/agenda.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/models/professional.dart';
import 'package:beauty/common/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'rendez_vous.freezed.dart';
part 'rendez_vous.g.dart';

@freezed
class RendezVous with _$RendezVous {
  const factory RendezVous({
    required String id,
    required String status,
    @JsonKey(name: 'professional_phone') required String professionalPhone,
    required User user,
    required DateTime day,
    required Catalogue realisation,
    required Professional professional,
    required Creneau creneau,
  }) = _RendezVous;

  factory RendezVous.fromJson(Map<String, dynamic> json) =>
      _$RendezVousFromJson(json);
}
