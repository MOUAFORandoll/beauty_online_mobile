// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rendez_vous.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RendezVous _$RendezVousFromJson(Map<String, dynamic> json) {
  return _RendezVous.fromJson(json);
}

/// @nodoc
mixin _$RendezVous {
  String get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'professional_phone')
  String get professionalPhone => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;
  DateTime get day => throw _privateConstructorUsedError;
  Catalogue get realisation => throw _privateConstructorUsedError;
  Professional get professional => throw _privateConstructorUsedError;
  Creneau get creneau => throw _privateConstructorUsedError;

  /// Serializes this RendezVous to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RendezVous
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RendezVousCopyWith<RendezVous> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RendezVousCopyWith<$Res> {
  factory $RendezVousCopyWith(
          RendezVous value, $Res Function(RendezVous) then) =
      _$RendezVousCopyWithImpl<$Res, RendezVous>;
  @useResult
  $Res call(
      {String id,
      String status,
      @JsonKey(name: 'professional_phone') String professionalPhone,
      User user,
      DateTime day,
      Catalogue realisation,
      Professional professional,
      Creneau creneau});

  $UserCopyWith<$Res> get user;
  $CatalogueCopyWith<$Res> get realisation;
  $ProfessionalCopyWith<$Res> get professional;
  $CreneauCopyWith<$Res> get creneau;
}

/// @nodoc
class _$RendezVousCopyWithImpl<$Res, $Val extends RendezVous>
    implements $RendezVousCopyWith<$Res> {
  _$RendezVousCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RendezVous
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? professionalPhone = null,
    Object? user = null,
    Object? day = null,
    Object? realisation = null,
    Object? professional = null,
    Object? creneau = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      professionalPhone: null == professionalPhone
          ? _value.professionalPhone
          : professionalPhone // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as DateTime,
      realisation: null == realisation
          ? _value.realisation
          : realisation // ignore: cast_nullable_to_non_nullable
              as Catalogue,
      professional: null == professional
          ? _value.professional
          : professional // ignore: cast_nullable_to_non_nullable
              as Professional,
      creneau: null == creneau
          ? _value.creneau
          : creneau // ignore: cast_nullable_to_non_nullable
              as Creneau,
    ) as $Val);
  }

  /// Create a copy of RendezVous
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of RendezVous
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CatalogueCopyWith<$Res> get realisation {
    return $CatalogueCopyWith<$Res>(_value.realisation, (value) {
      return _then(_value.copyWith(realisation: value) as $Val);
    });
  }

  /// Create a copy of RendezVous
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfessionalCopyWith<$Res> get professional {
    return $ProfessionalCopyWith<$Res>(_value.professional, (value) {
      return _then(_value.copyWith(professional: value) as $Val);
    });
  }

  /// Create a copy of RendezVous
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CreneauCopyWith<$Res> get creneau {
    return $CreneauCopyWith<$Res>(_value.creneau, (value) {
      return _then(_value.copyWith(creneau: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RendezVousImplCopyWith<$Res>
    implements $RendezVousCopyWith<$Res> {
  factory _$$RendezVousImplCopyWith(
          _$RendezVousImpl value, $Res Function(_$RendezVousImpl) then) =
      __$$RendezVousImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String status,
      @JsonKey(name: 'professional_phone') String professionalPhone,
      User user,
      DateTime day,
      Catalogue realisation,
      Professional professional,
      Creneau creneau});

  @override
  $UserCopyWith<$Res> get user;
  @override
  $CatalogueCopyWith<$Res> get realisation;
  @override
  $ProfessionalCopyWith<$Res> get professional;
  @override
  $CreneauCopyWith<$Res> get creneau;
}

/// @nodoc
class __$$RendezVousImplCopyWithImpl<$Res>
    extends _$RendezVousCopyWithImpl<$Res, _$RendezVousImpl>
    implements _$$RendezVousImplCopyWith<$Res> {
  __$$RendezVousImplCopyWithImpl(
      _$RendezVousImpl _value, $Res Function(_$RendezVousImpl) _then)
      : super(_value, _then);

  /// Create a copy of RendezVous
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? professionalPhone = null,
    Object? user = null,
    Object? day = null,
    Object? realisation = null,
    Object? professional = null,
    Object? creneau = null,
  }) {
    return _then(_$RendezVousImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      professionalPhone: null == professionalPhone
          ? _value.professionalPhone
          : professionalPhone // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as DateTime,
      realisation: null == realisation
          ? _value.realisation
          : realisation // ignore: cast_nullable_to_non_nullable
              as Catalogue,
      professional: null == professional
          ? _value.professional
          : professional // ignore: cast_nullable_to_non_nullable
              as Professional,
      creneau: null == creneau
          ? _value.creneau
          : creneau // ignore: cast_nullable_to_non_nullable
              as Creneau,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RendezVousImpl implements _RendezVous {
  const _$RendezVousImpl(
      {required this.id,
      required this.status,
      @JsonKey(name: 'professional_phone') required this.professionalPhone,
      required this.user,
      required this.day,
      required this.realisation,
      required this.professional,
      required this.creneau});

  factory _$RendezVousImpl.fromJson(Map<String, dynamic> json) =>
      _$$RendezVousImplFromJson(json);

  @override
  final String id;
  @override
  final String status;
  @override
  @JsonKey(name: 'professional_phone')
  final String professionalPhone;
  @override
  final User user;
  @override
  final DateTime day;
  @override
  final Catalogue realisation;
  @override
  final Professional professional;
  @override
  final Creneau creneau;

  @override
  String toString() {
    return 'RendezVous(id: $id, status: $status, professionalPhone: $professionalPhone, user: $user, day: $day, realisation: $realisation, professional: $professional, creneau: $creneau)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RendezVousImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.professionalPhone, professionalPhone) ||
                other.professionalPhone == professionalPhone) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.realisation, realisation) ||
                other.realisation == realisation) &&
            (identical(other.professional, professional) ||
                other.professional == professional) &&
            (identical(other.creneau, creneau) || other.creneau == creneau));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, status, professionalPhone,
      user, day, realisation, professional, creneau);

  /// Create a copy of RendezVous
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RendezVousImplCopyWith<_$RendezVousImpl> get copyWith =>
      __$$RendezVousImplCopyWithImpl<_$RendezVousImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RendezVousImplToJson(
      this,
    );
  }
}

abstract class _RendezVous implements RendezVous {
  const factory _RendezVous(
      {required final String id,
      required final String status,
      @JsonKey(name: 'professional_phone')
      required final String professionalPhone,
      required final User user,
      required final DateTime day,
      required final Catalogue realisation,
      required final Professional professional,
      required final Creneau creneau}) = _$RendezVousImpl;

  factory _RendezVous.fromJson(Map<String, dynamic> json) =
      _$RendezVousImpl.fromJson;

  @override
  String get id;
  @override
  String get status;
  @override
  @JsonKey(name: 'professional_phone')
  String get professionalPhone;
  @override
  User get user;
  @override
  DateTime get day;
  @override
  Catalogue get realisation;
  @override
  Professional get professional;
  @override
  Creneau get creneau;

  /// Create a copy of RendezVous
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RendezVousImplCopyWith<_$RendezVousImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
