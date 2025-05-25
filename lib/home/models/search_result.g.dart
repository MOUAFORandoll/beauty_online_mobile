// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchResultImpl _$$SearchResultImplFromJson(Map<String, dynamic> json) =>
    _$SearchResultImpl(
      type: json['type'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$$SearchResultImplToJson(_$SearchResultImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'url': instance.url,
      'data': instance.data,
    };
