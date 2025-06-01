// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalogue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CatalogueImpl _$$CatalogueImplFromJson(Map<String, dynamic> json) =>
    _$CatalogueImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      price: json['price'] as String?,
      profileProfessionnelId: json['profile_professionnel_id'] as String,
      realisationFiles: (json['realisation_files'] as List<dynamic>)
          .map((e) => RealisationFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      isVideo: json['is_video'] as bool?,
      video: json['video'] == null
          ? null
          : Video.fromJson(json['video'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CatalogueImplToJson(_$CatalogueImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'profile_professionnel_id': instance.profileProfessionnelId,
      'realisation_files': instance.realisationFiles,
      'is_video': instance.isVideo,
      'video': instance.video,
    };
