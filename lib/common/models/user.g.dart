// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      pictureUrl: json['pictureUrl'] as String,
      email: json['email'] as String,
      userName: json['userName'] as String?,
      firebaseUID: json['firebaseUID'] as String,
      authProvider: json['authProvider'] as String,
      countryCode: json['countryCode'] as String?,
      phone: json['phone'] as String?,
      codePhone: json['codePhone'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pictureUrl': instance.pictureUrl,
      'email': instance.email,
      'userName': instance.userName,
      'firebaseUID': instance.firebaseUID,
      'authProvider': instance.authProvider,
      'countryCode': instance.countryCode,
      'phone': instance.phone,
      'codePhone': instance.codePhone,
    };
