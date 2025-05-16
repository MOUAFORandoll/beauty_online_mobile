// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgendaImpl _$$AgendaImplFromJson(Map<String, dynamic> json) => _$AgendaImpl(
      id: json['id'] as String,
      day: DateTime.parse(json['day'] as String),
      crenaux: (json['crenaux'] as List<dynamic>)
          .map((e) => Crenau.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AgendaImplToJson(_$AgendaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day.toIso8601String(),
      'crenaux': instance.crenaux,
    };

_$CrenauImpl _$$CrenauImplFromJson(Map<String, dynamic> json) => _$CrenauImpl(
      id: json['id'] as String,
      startTimeAvailable: json['startTimeAvailable'] as String,
      endTimeAvailable: json['endTimeAvailable'] as String,
    );

Map<String, dynamic> _$$CrenauImplToJson(_$CrenauImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTimeAvailable': instance.startTimeAvailable,
      'endTimeAvailable': instance.endTimeAvailable,
    };
