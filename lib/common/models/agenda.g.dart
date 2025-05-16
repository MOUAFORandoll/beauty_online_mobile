// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgendaImpl _$$AgendaImplFromJson(Map<String, dynamic> json) => _$AgendaImpl(
      id: json['id'] as String,
      day: DateTime.parse(json['day'] as String),
      creneaux: (json['creneaux'] as List<dynamic>)
          .map((e) => Creneau.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AgendaImplToJson(_$AgendaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day.toIso8601String(),
      'creneaux': instance.creneaux,
    };

_$CreneauImpl _$$CreneauImplFromJson(Map<String, dynamic> json) => _$CreneauImpl(
      id: json['id'] as String,
      startTimeAvailable: json['startTimeAvailable'] as String,
      endTimeAvailable: json['endTimeAvailable'] as String,
    );

Map<String, dynamic> _$$CreneauImplToJson(_$CreneauImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTimeAvailable': instance.startTimeAvailable,
      'endTimeAvailable': instance.endTimeAvailable,
    };
