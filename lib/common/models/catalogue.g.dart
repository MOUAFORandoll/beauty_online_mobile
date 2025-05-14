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
    );

Map<String, dynamic> _$$CatalogueImplToJson(_$CatalogueImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'profile_professionnel_id': instance.profileProfessionnelId,
      'realisation_files': instance.realisationFiles,
    };

_$RealisationFileImpl _$$RealisationFileImplFromJson(
        Map<String, dynamic> json) =>
    _$RealisationFileImpl(
      id: json['id'] as String,
      filePath: json['file_path'] as String,
    );

Map<String, dynamic> _$$RealisationFileImplToJson(
        _$RealisationFileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'file_path': instance.filePath,
    };
