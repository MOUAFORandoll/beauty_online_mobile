// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rendez_vous.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RendezVousImpl _$$RendezVousImplFromJson(Map<String, dynamic> json) =>
    _$RendezVousImpl(
      id: json['id'] as String,
      status: json['status'] as String,
      professionalPhone: json['professional_phone'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      day: DateTime.parse(json['day'] as String),
      realisation:
          Catalogue.fromJson(json['realisation'] as Map<String, dynamic>),
      professional:
          Professional.fromJson(json['professional'] as Map<String, dynamic>),
      creneau: Creneau.fromJson(json['creneau'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RendezVousImplToJson(_$RendezVousImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'professional_phone': instance.professionalPhone,
      'user': instance.user,
      'day': instance.day.toIso8601String(),
      'realisation': instance.realisation,
      'professional': instance.professional,
      'creneau': instance.creneau,
    };
