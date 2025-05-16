import 'package:freezed_annotation/freezed_annotation.dart';

part 'agenda.freezed.dart';
part 'agenda.g.dart';

@freezed
class Agenda with _$Agenda {
  const factory Agenda({
    required String id,
    required DateTime day,
    required List<Creneau> creneaux,
  }) = _Agenda;

  factory Agenda.fromJson(Map<String, dynamic> json) => _$AgendaFromJson(json);
}

@freezed
class Creneau with _$Creneau {
  const factory Creneau({
    required String id,
    required String startTimeAvailable,
    required String endTimeAvailable,
  }) = _Creneau;

  factory Creneau.fromJson(Map<String, dynamic> json) => _$CreneauFromJson(json);
}
