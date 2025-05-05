// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ErrorImpl _$$ErrorImplFromJson(Map<String, dynamic> json) => _$ErrorImpl(
      code: json['code'] as String,
      displayMessages: (json['display_messages'] as List<dynamic>?)
          ?.map((e) => IDisplayText.fromJson(e as Map<String, dynamic>))
          .toList(),
      url: json['url'] as String,
    );

Map<String, dynamic> _$$ErrorImplToJson(_$ErrorImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'display_messages': instance.displayMessages,
      'url': instance.url,
    };

_$IDisplayTextImpl _$$IDisplayTextImplFromJson(Map<String, dynamic> json) =>
    _$IDisplayTextImpl(
      lang: json['lang'] as String,
      value: json['value'],
    );

Map<String, dynamic> _$$IDisplayTextImplToJson(_$IDisplayTextImpl instance) =>
    <String, dynamic>{
      'lang': instance.lang,
      'value': instance.value,
    };
