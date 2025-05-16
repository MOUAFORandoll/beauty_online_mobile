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
  List<Creneau> get creneaux => throw _privateConstructorUsedError;

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
  $Res call({String id, DateTime day, List<Creneau> creneaux});
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
    Object? creneaux = null,
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
      creneaux: null == creneaux
          ? _value.creneaux
          : creneaux // ignore: cast_nullable_to_non_nullable
              as List<Creneau>,
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
  $Res call({String id, DateTime day, List<Creneau> creneaux});
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
    Object? creneaux = null,
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
      creneaux: null == creneaux
          ? _value._creneaux
          : creneaux // ignore: cast_nullable_to_non_nullable
              as List<Creneau>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgendaImpl implements _Agenda {
  const _$AgendaImpl(
      {required this.id,
      required this.day,
      required final List<Creneau> creneaux})
      : _creneaux = creneaux;

  factory _$AgendaImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgendaImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime day;
  final List<Creneau> _creneaux;
  @override
  List<Creneau> get creneaux {
    if (_creneaux is EqualUnmodifiableListView) return _creneaux;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_creneaux);
  }

  @override
  String toString() {
    return 'Agenda(id: $id, day: $day, creneaux: $creneaux)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgendaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.day, day) || other.day == day) &&
            const DeepCollectionEquality().equals(other._creneaux, _creneaux));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, day, const DeepCollectionEquality().hash(_creneaux));

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
      required final List<Creneau> creneaux}) = _$AgendaImpl;

  factory _Agenda.fromJson(Map<String, dynamic> json) = _$AgendaImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get day;
  @override
  List<Creneau> get creneaux;

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgendaImplCopyWith<_$AgendaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Creneau _$CreneauFromJson(Map<String, dynamic> json) {
  return _Creneau.fromJson(json);
}

/// @nodoc
mixin _$Creneau {
  String get id => throw _privateConstructorUsedError;
  String get startTimeAvailable => throw _privateConstructorUsedError;
  String get endTimeAvailable => throw _privateConstructorUsedError;

  /// Serializes this Creneau to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Creneau
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreneauCopyWith<Creneau> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreneauCopyWith<$Res> {
  factory $CreneauCopyWith(Creneau value, $Res Function(Creneau) then) =
      _$CreneauCopyWithImpl<$Res, Creneau>;
  @useResult
  $Res call({String id, String startTimeAvailable, String endTimeAvailable});
}

/// @nodoc
class _$CreneauCopyWithImpl<$Res, $Val extends Creneau>
    implements $CreneauCopyWith<$Res> {
  _$CreneauCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Creneau
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
abstract class _$$CreneauImplCopyWith<$Res> implements $CreneauCopyWith<$Res> {
  factory _$$CreneauImplCopyWith(
          _$CreneauImpl value, $Res Function(_$CreneauImpl) then) =
      __$$CreneauImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String startTimeAvailable, String endTimeAvailable});
}

/// @nodoc
class __$$CreneauImplCopyWithImpl<$Res>
    extends _$CreneauCopyWithImpl<$Res, _$CreneauImpl>
    implements _$$CreneauImplCopyWith<$Res> {
  __$$CreneauImplCopyWithImpl(
      _$CreneauImpl _value, $Res Function(_$CreneauImpl) _then)
      : super(_value, _then);

  /// Create a copy of Creneau
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startTimeAvailable = null,
    Object? endTimeAvailable = null,
  }) {
    return _then(_$CreneauImpl(
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
class _$CreneauImpl implements _Creneau {
  const _$CreneauImpl(
      {required this.id,
      required this.startTimeAvailable,
      required this.endTimeAvailable});

  factory _$CreneauImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreneauImplFromJson(json);

  @override
  final String id;
  @override
  final String startTimeAvailable;
  @override
  final String endTimeAvailable;

  @override
  String toString() {
    return 'Creneau(id: $id, startTimeAvailable: $startTimeAvailable, endTimeAvailable: $endTimeAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreneauImpl &&
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

  /// Create a copy of Creneau
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreneauImplCopyWith<_$CreneauImpl> get copyWith =>
      __$$CreneauImplCopyWithImpl<_$CreneauImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreneauImplToJson(
      this,
    );
  }
}

abstract class _Creneau implements Creneau {
  const factory _Creneau(
      {required final String id,
      required final String startTimeAvailable,
      required final String endTimeAvailable}) = _$CreneauImpl;

  factory _Creneau.fromJson(Map<String, dynamic> json) = _$CreneauImpl.fromJson;

  @override
  String get id;
  @override
  String get startTimeAvailable;
  @override
  String get endTimeAvailable;

  /// Create a copy of Creneau
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreneauImplCopyWith<_$CreneauImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
