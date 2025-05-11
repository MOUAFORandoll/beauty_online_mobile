import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:beauty/common/utils/datetime_converter.dart';

part 'user.freezed.dart';
part 'user.g.dart';
@freezed
class User with _$User {
  const User._();

  const factory User({
    required String id,
    required String pictureUrl,
    required String email,
      String? userName,
    required String firebaseUID,
    required String authProvider,
      String? countryCode,
      String? phone,
      String? codePhone,
      
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
