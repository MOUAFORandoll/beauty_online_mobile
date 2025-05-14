// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActuImpl _$$ActuImplFromJson(Map<String, dynamic> json) => _$ActuImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      price: json['price'] as String,
      profileProfessionnel: Professional.fromJson(
          json['profile_professionnel'] as Map<String, dynamic>),
      realisationFiles: (json['r,ealisation_files'] as List<dynamic>)
          .map((e) => RealisationFile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ActuImplToJson(_$ActuImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'profile_professionnel': instance.profileProfessionnel,
      'r,ealisation_files': instance.realisationFiles,
    };
