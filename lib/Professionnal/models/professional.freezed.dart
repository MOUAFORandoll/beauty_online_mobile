// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'professional.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Professional _$ProfessionalFromJson(Map<String, dynamic> json) {
  return _Professional.fromJson(json);
}

/// @nodoc
mixin _$Professional {
  String get id => throw _privateConstructorUsedError;
  String get namePro => throw _privateConstructorUsedError;
  String get service => throw _privateConstructorUsedError;

  /// Serializes this Professional to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Professional
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfessionalCopyWith<Professional> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfessionalCopyWith<$Res> {
  factory $ProfessionalCopyWith(
          Professional value, $Res Function(Professional) then) =
      _$ProfessionalCopyWithImpl<$Res, Professional>;
  @useResult
  $Res call({String id, String namePro, String service});
}

/// @nodoc
class _$ProfessionalCopyWithImpl<$Res, $Val extends Professional>
    implements $ProfessionalCopyWith<$Res> {
  _$ProfessionalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Professional
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? namePro = null,
    Object? service = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      namePro: null == namePro
          ? _value.namePro
          : namePro // ignore: cast_nullable_to_non_nullable
              as String,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfessionalImplCopyWith<$Res>
    implements $ProfessionalCopyWith<$Res> {
  factory _$$ProfessionalImplCopyWith(
          _$ProfessionalImpl value, $Res Function(_$ProfessionalImpl) then) =
      __$$ProfessionalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String namePro, String service});
}

/// @nodoc
class __$$ProfessionalImplCopyWithImpl<$Res>
    extends _$ProfessionalCopyWithImpl<$Res, _$ProfessionalImpl>
    implements _$$ProfessionalImplCopyWith<$Res> {
  __$$ProfessionalImplCopyWithImpl(
      _$ProfessionalImpl _value, $Res Function(_$ProfessionalImpl) _then)
      : super(_value, _then);

  /// Create a copy of Professional
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? namePro = null,
    Object? service = null,
  }) {
    return _then(_$ProfessionalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      namePro: null == namePro
          ? _value.namePro
          : namePro // ignore: cast_nullable_to_non_nullable
              as String,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfessionalImpl extends _Professional {
  const _$ProfessionalImpl(
      {required this.id, required this.namePro, required this.service})
      : super._();

  factory _$ProfessionalImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfessionalImplFromJson(json);

  @override
  final String id;
  @override
  final String namePro;
  @override
  final String service;

  @override
  String toString() {
    return 'Professional(id: $id, namePro: $namePro, service: $service)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfessionalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.namePro, namePro) || other.namePro == namePro) &&
            (identical(other.service, service) || other.service == service));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, namePro, service);

  /// Create a copy of Professional
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfessionalImplCopyWith<_$ProfessionalImpl> get copyWith =>
      __$$ProfessionalImplCopyWithImpl<_$ProfessionalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfessionalImplToJson(
      this,
    );
  }
}

abstract class _Professional extends Professional {
  const factory _Professional(
      {required final String id,
      required final String namePro,
      required final String service}) = _$ProfessionalImpl;
  const _Professional._() : super._();

  factory _Professional.fromJson(Map<String, dynamic> json) =
      _$ProfessionalImpl.fromJson;

  @override
  String get id;
  @override
  String get namePro;
  @override
  String get service;

  /// Create a copy of Professional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfessionalImplCopyWith<_$ProfessionalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
