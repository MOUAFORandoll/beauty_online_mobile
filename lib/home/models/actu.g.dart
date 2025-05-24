// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActuImpl _$$ActuImplFromJson(Map<String, dynamic> json) => _$ActuImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      price: json['price'] as String?,
      profileProfessionnel: Professional.fromJson(
          json['profile_professionnel'] as Map<String, dynamic>),
      realisationFiles: (json['realisation_files'] as List<dynamic>)
          .map((e) => RealisationFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      nombreVues: (json['nombre_vues'] as num).toInt(),
      nombrePartages: (json['nombre_partages'] as num).toInt(),
    );

Map<String, dynamic> _$$ActuImplToJson(_$ActuImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'profile_professionnel': instance.profileProfessionnel,
      'realisation_files': instance.realisationFiles,
      'nombre_vues': instance.nombreVues,
      'nombre_partages': instance.nombrePartages,
    };
