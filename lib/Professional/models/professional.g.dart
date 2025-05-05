// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professional.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfessionalImpl _$$ProfessionalImplFromJson(Map<String, dynamic> json) =>
    _$ProfessionalImpl(
      id: json['id'] as String,
      namePro: json['name_pro'] as String,
      service: json['service'] as String,
      position: Position.fromJson(json['position'] as Map<String, dynamic>),
      nombreReservation: (json['nombre_reservation'] as num).toInt(),
      nombreCatalogue: (json['nombre_catalogue'] as num).toInt(),
      nombreActes: (json['nombre_actes'] as num).toInt(),
    );

Map<String, dynamic> _$$ProfessionalImplToJson(_$ProfessionalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_pro': instance.namePro,
      'service': instance.service,
      'position': instance.position,
      'nombre_reservation': instance.nombreReservation,
      'nombre_catalogue': instance.nombreCatalogue,
      'nombre_actes': instance.nombreActes,
    };

_$PositionImpl _$$PositionImplFromJson(Map<String, dynamic> json) =>
    _$PositionImpl(
      titleEmplacement: json['title_emplacement'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      town: json['town'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$$PositionImplToJson(_$PositionImpl instance) =>
    <String, dynamic>{
      'title_emplacement': instance.titleEmplacement,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'town': instance.town,
      'country': instance.country,
    };
