// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get pictureUrl => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  String get firebaseUID => throw _privateConstructorUsedError;
  String get authProvider => throw _privateConstructorUsedError;
  String? get countryCode => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get codePhone => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String pictureUrl,
      String email,
      String? userName,
      String firebaseUID,
      String authProvider,
      String? countryCode,
      String? phone,
      String? codePhone});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pictureUrl = null,
    Object? email = null,
    Object? userName = freezed,
    Object? firebaseUID = null,
    Object? authProvider = null,
    Object? countryCode = freezed,
    Object? phone = freezed,
    Object? codePhone = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pictureUrl: null == pictureUrl
          ? _value.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      firebaseUID: null == firebaseUID
          ? _value.firebaseUID
          : firebaseUID // ignore: cast_nullable_to_non_nullable
              as String,
      authProvider: null == authProvider
          ? _value.authProvider
          : authProvider // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      codePhone: freezed == codePhone
          ? _value.codePhone
          : codePhone // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String pictureUrl,
      String email,
      String? userName,
      String firebaseUID,
      String authProvider,
      String? countryCode,
      String? phone,
      String? codePhone});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pictureUrl = null,
    Object? email = null,
    Object? userName = freezed,
    Object? firebaseUID = null,
    Object? authProvider = null,
    Object? countryCode = freezed,
    Object? phone = freezed,
    Object? codePhone = freezed,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pictureUrl: null == pictureUrl
          ? _value.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      firebaseUID: null == firebaseUID
          ? _value.firebaseUID
          : firebaseUID // ignore: cast_nullable_to_non_nullable
              as String,
      authProvider: null == authProvider
          ? _value.authProvider
          : authProvider // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      codePhone: freezed == codePhone
          ? _value.codePhone
          : codePhone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl extends _User {
  const _$UserImpl(
      {required this.id,
      required this.pictureUrl,
      required this.email,
      this.userName,
      required this.firebaseUID,
      required this.authProvider,
      this.countryCode,
      this.phone,
      this.codePhone})
      : super._();

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String pictureUrl;
  @override
  final String email;
  @override
  final String? userName;
  @override
  final String firebaseUID;
  @override
  final String authProvider;
  @override
  final String? countryCode;
  @override
  final String? phone;
  @override
  final String? codePhone;

  @override
  String toString() {
    return 'User(id: $id, pictureUrl: $pictureUrl, email: $email, userName: $userName, firebaseUID: $firebaseUID, authProvider: $authProvider, countryCode: $countryCode, phone: $phone, codePhone: $codePhone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pictureUrl, pictureUrl) ||
                other.pictureUrl == pictureUrl) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.firebaseUID, firebaseUID) ||
                other.firebaseUID == firebaseUID) &&
            (identical(other.authProvider, authProvider) ||
                other.authProvider == authProvider) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.codePhone, codePhone) ||
                other.codePhone == codePhone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, pictureUrl, email, userName,
      firebaseUID, authProvider, countryCode, phone, codePhone);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User extends User {
  const factory _User(
      {required final String id,
      required final String pictureUrl,
      required final String email,
      final String? userName,
      required final String firebaseUID,
      required final String authProvider,
      final String? countryCode,
      final String? phone,
      final String? codePhone}) = _$UserImpl;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get pictureUrl;
  @override
  String get email;
  @override
  String? get userName;
  @override
  String get firebaseUID;
  @override
  String get authProvider;
  @override
  String? get countryCode;
  @override
  String? get phone;
  @override
  String? get codePhone;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
