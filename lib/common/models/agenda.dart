import 'package:freezed_annotation/freezed_annotation.dart';

part 'agenda.freezed.dart';
part 'agenda.g.dart';

@freezed
class Agenda with _$Agenda {
  const factory Agenda({
    required String id,
    required DateTime day,
    required List<Crenau> crenaux,
  }) = _Agenda;

  factory Agenda.fromJson(Map<String, dynamic> json) => _$AgendaFromJson(json);
}

@freezed
class Crenau with _$Crenau {
  const factory Crenau({
    required String id,
    required String startTimeAvailable,
    required String endTimeAvailable,
  }) = _Crenau;

  factory Crenau.fromJson(Map<String, dynamic> json) => _$CrenauFromJson(json);
}
