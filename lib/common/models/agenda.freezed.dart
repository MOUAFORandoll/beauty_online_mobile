// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agenda.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Agenda _$AgendaFromJson(Map<String, dynamic> json) {
  return _Agenda.fromJson(json);
}

/// @nodoc
mixin _$Agenda {
  String get id => throw _privateConstructorUsedError;
  DateTime get day => throw _privateConstructorUsedError;
  List<Crenau> get crenaux => throw _privateConstructorUsedError;

  /// Serializes this Agenda to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgendaCopyWith<Agenda> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgendaCopyWith<$Res> {
  factory $AgendaCopyWith(Agenda value, $Res Function(Agenda) then) =
      _$AgendaCopyWithImpl<$Res, Agenda>;
  @useResult
  $Res call({String id, DateTime day, List<Crenau> crenaux});
}

/// @nodoc
class _$AgendaCopyWithImpl<$Res, $Val extends Agenda>
    implements $AgendaCopyWith<$Res> {
  _$AgendaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? day = null,
    Object? crenaux = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as DateTime,
      crenaux: null == crenaux
          ? _value.crenaux
          : crenaux // ignore: cast_nullable_to_non_nullable
              as List<Crenau>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgendaImplCopyWith<$Res> implements $AgendaCopyWith<$Res> {
  factory _$$AgendaImplCopyWith(
          _$AgendaImpl value, $Res Function(_$AgendaImpl) then) =
      __$$AgendaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, DateTime day, List<Crenau> crenaux});
}

/// @nodoc
class __$$AgendaImplCopyWithImpl<$Res>
    extends _$AgendaCopyWithImpl<$Res, _$AgendaImpl>
    implements _$$AgendaImplCopyWith<$Res> {
  __$$AgendaImplCopyWithImpl(
      _$AgendaImpl _value, $Res Function(_$AgendaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? day = null,
    Object? crenaux = null,
  }) {
    return _then(_$AgendaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as DateTime,
      crenaux: null == crenaux
          ? _value._crenaux
          : crenaux // ignore: cast_nullable_to_non_nullable
              as List<Crenau>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgendaImpl implements _Agenda {
  const _$AgendaImpl(
      {required this.id,
      required this.day,
      required final List<Crenau> crenaux})
      : _crenaux = crenaux;

  factory _$AgendaImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgendaImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime day;
  final List<Crenau> _crenaux;
  @override
  List<Crenau> get crenaux {
    if (_crenaux is EqualUnmodifiableListView) return _crenaux;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_crenaux);
  }

  @override
  String toString() {
    return 'Agenda(id: $id, day: $day, crenaux: $crenaux)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgendaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.day, day) || other.day == day) &&
            const DeepCollectionEquality().equals(other._crenaux, _crenaux));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, day, const DeepCollectionEquality().hash(_crenaux));

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgendaImplCopyWith<_$AgendaImpl> get copyWith =>
      __$$AgendaImplCopyWithImpl<_$AgendaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgendaImplToJson(
      this,
    );
  }
}

abstract class _Agenda implements Agenda {
  const factory _Agenda(
      {required final String id,
      required final DateTime day,
      required final List<Crenau> crenaux}) = _$AgendaImpl;

  factory _Agenda.fromJson(Map<String, dynamic> json) = _$AgendaImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get day;
  @override
  List<Crenau> get crenaux;

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgendaImplCopyWith<_$AgendaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Crenau _$CrenauFromJson(Map<String, dynamic> json) {
  return _Crenau.fromJson(json);
}

/// @nodoc
mixin _$Crenau {
  String get id => throw _privateConstructorUsedError;
  String get startTimeAvailable => throw _privateConstructorUsedError;
  String get endTimeAvailable => throw _privateConstructorUsedError;

  /// Serializes this Crenau to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Crenau
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CrenauCopyWith<Crenau> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CrenauCopyWith<$Res> {
  factory $CrenauCopyWith(Crenau value, $Res Function(Crenau) then) =
      _$CrenauCopyWithImpl<$Res, Crenau>;
  @useResult
  $Res call({String id, String startTimeAvailable, String endTimeAvailable});
}

/// @nodoc
class _$CrenauCopyWithImpl<$Res, $Val extends Crenau>
    implements $CrenauCopyWith<$Res> {
  _$CrenauCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Crenau
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startTimeAvailable = null,
    Object? endTimeAvailable = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startTimeAvailable: null == startTimeAvailable
          ? _value.startTimeAvailable
          : startTimeAvailable // ignore: cast_nullable_to_non_nullable
              as String,
      endTimeAvailable: null == endTimeAvailable
          ? _value.endTimeAvailable
          : endTimeAvailable // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CrenauImplCopyWith<$Res> implements $CrenauCopyWith<$Res> {
  factory _$$CrenauImplCopyWith(
          _$CrenauImpl value, $Res Function(_$CrenauImpl) then) =
      __$$CrenauImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String startTimeAvailable, String endTimeAvailable});
}

/// @nodoc
class __$$CrenauImplCopyWithImpl<$Res>
    extends _$CrenauCopyWithImpl<$Res, _$CrenauImpl>
    implements _$$CrenauImplCopyWith<$Res> {
  __$$CrenauImplCopyWithImpl(
      _$CrenauImpl _value, $Res Function(_$CrenauImpl) _then)
      : super(_value, _then);

  /// Create a copy of Crenau
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startTimeAvailable = null,
    Object? endTimeAvailable = null,
  }) {
    return _then(_$CrenauImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startTimeAvailable: null == startTimeAvailable
          ? _value.startTimeAvailable
          : startTimeAvailable // ignore: cast_nullable_to_non_nullable
              as String,
      endTimeAvailable: null == endTimeAvailable
          ? _value.endTimeAvailable
          : endTimeAvailable // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CrenauImpl implements _Crenau {
  const _$CrenauImpl(
      {required this.id,
      required this.startTimeAvailable,
      required this.endTimeAvailable});

  factory _$CrenauImpl.fromJson(Map<String, dynamic> json) =>
      _$$CrenauImplFromJson(json);

  @override
  final String id;
  @override
  final String startTimeAvailable;
  @override
  final String endTimeAvailable;

  @override
  String toString() {
    return 'Crenau(id: $id, startTimeAvailable: $startTimeAvailable, endTimeAvailable: $endTimeAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CrenauImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startTimeAvailable, startTimeAvailable) ||
                other.startTimeAvailable == startTimeAvailable) &&
            (identical(other.endTimeAvailable, endTimeAvailable) ||
                other.endTimeAvailable == endTimeAvailable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, startTimeAvailable, endTimeAvailable);

  /// Create a copy of Crenau
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CrenauImplCopyWith<_$CrenauImpl> get copyWith =>
      __$$CrenauImplCopyWithImpl<_$CrenauImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CrenauImplToJson(
      this,
    );
  }
}

abstract class _Crenau implements Crenau {
  const factory _Crenau(
      {required final String id,
      required final String startTimeAvailable,
      required final String endTimeAvailable}) = _$CrenauImpl;

  factory _Crenau.fromJson(Map<String, dynamic> json) = _$CrenauImpl.fromJson;

  @override
  String get id;
  @override
  String get startTimeAvailable;
  @override
  String get endTimeAvailable;

  /// Create a copy of Crenau
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CrenauImplCopyWith<_$CrenauImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
