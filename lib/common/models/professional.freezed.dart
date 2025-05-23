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
  @JsonKey(name: 'name_pro')
  String get namePro => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String get description => throw _privateConstructorUsedError;
  String? get service => throw _privateConstructorUsedError;
  Position? get position => throw _privateConstructorUsedError;
  String? get cover => throw _privateConstructorUsedError;
  @JsonKey(name: 'nombre_reservation')
  int get nombreReservation => throw _privateConstructorUsedError;
  @JsonKey(name: 'nombre_catalogue')
  int get nombreCatalogue => throw _privateConstructorUsedError;
  @JsonKey(name: 'nombre_actes')
  int get nombreActes => throw _privateConstructorUsedError;

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
  $Res call(
      {String id,
      @JsonKey(name: 'name_pro') String namePro,
      @JsonKey(name: 'description') String description,
      String? service,
      Position? position,
      String? cover,
      @JsonKey(name: 'nombre_reservation') int nombreReservation,
      @JsonKey(name: 'nombre_catalogue') int nombreCatalogue,
      @JsonKey(name: 'nombre_actes') int nombreActes});

  $PositionCopyWith<$Res>? get position;
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
    Object? description = null,
    Object? service = freezed,
    Object? position = freezed,
    Object? cover = freezed,
    Object? nombreReservation = null,
    Object? nombreCatalogue = null,
    Object? nombreActes = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position?,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      nombreReservation: null == nombreReservation
          ? _value.nombreReservation
          : nombreReservation // ignore: cast_nullable_to_non_nullable
              as int,
      nombreCatalogue: null == nombreCatalogue
          ? _value.nombreCatalogue
          : nombreCatalogue // ignore: cast_nullable_to_non_nullable
              as int,
      nombreActes: null == nombreActes
          ? _value.nombreActes
          : nombreActes // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of Professional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PositionCopyWith<$Res>? get position {
    if (_value.position == null) {
      return null;
    }

    return $PositionCopyWith<$Res>(_value.position!, (value) {
      return _then(_value.copyWith(position: value) as $Val);
    });
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
  $Res call(
      {String id,
      @JsonKey(name: 'name_pro') String namePro,
      @JsonKey(name: 'description') String description,
      String? service,
      Position? position,
      String? cover,
      @JsonKey(name: 'nombre_reservation') int nombreReservation,
      @JsonKey(name: 'nombre_catalogue') int nombreCatalogue,
      @JsonKey(name: 'nombre_actes') int nombreActes});

  @override
  $PositionCopyWith<$Res>? get position;
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
    Object? description = null,
    Object? service = freezed,
    Object? position = freezed,
    Object? cover = freezed,
    Object? nombreReservation = null,
    Object? nombreCatalogue = null,
    Object? nombreActes = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      service: freezed == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position?,
      cover: freezed == cover
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      nombreReservation: null == nombreReservation
          ? _value.nombreReservation
          : nombreReservation // ignore: cast_nullable_to_non_nullable
              as int,
      nombreCatalogue: null == nombreCatalogue
          ? _value.nombreCatalogue
          : nombreCatalogue // ignore: cast_nullable_to_non_nullable
              as int,
      nombreActes: null == nombreActes
          ? _value.nombreActes
          : nombreActes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfessionalImpl extends _Professional {
  const _$ProfessionalImpl(
      {required this.id,
      @JsonKey(name: 'name_pro') required this.namePro,
      @JsonKey(name: 'description') required this.description,
      this.service,
      this.position,
      this.cover,
      @JsonKey(name: 'nombre_reservation') required this.nombreReservation,
      @JsonKey(name: 'nombre_catalogue') required this.nombreCatalogue,
      @JsonKey(name: 'nombre_actes') required this.nombreActes})
      : super._();

  factory _$ProfessionalImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfessionalImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'name_pro')
  final String namePro;
  @override
  @JsonKey(name: 'description')
  final String description;
  @override
  final String? service;
  @override
  final Position? position;
  @override
  final String? cover;
  @override
  @JsonKey(name: 'nombre_reservation')
  final int nombreReservation;
  @override
  @JsonKey(name: 'nombre_catalogue')
  final int nombreCatalogue;
  @override
  @JsonKey(name: 'nombre_actes')
  final int nombreActes;

  @override
  String toString() {
    return 'Professional(id: $id, namePro: $namePro, description: $description, service: $service, position: $position, cover: $cover, nombreReservation: $nombreReservation, nombreCatalogue: $nombreCatalogue, nombreActes: $nombreActes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfessionalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.namePro, namePro) || other.namePro == namePro) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            (identical(other.nombreReservation, nombreReservation) ||
                other.nombreReservation == nombreReservation) &&
            (identical(other.nombreCatalogue, nombreCatalogue) ||
                other.nombreCatalogue == nombreCatalogue) &&
            (identical(other.nombreActes, nombreActes) ||
                other.nombreActes == nombreActes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      namePro,
      description,
      service,
      position,
      cover,
      nombreReservation,
      nombreCatalogue,
      nombreActes);

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
      @JsonKey(name: 'name_pro') required final String namePro,
      @JsonKey(name: 'description') required final String description,
      final String? service,
      final Position? position,
      final String? cover,
      @JsonKey(name: 'nombre_reservation') required final int nombreReservation,
      @JsonKey(name: 'nombre_catalogue') required final int nombreCatalogue,
      @JsonKey(name: 'nombre_actes')
      required final int nombreActes}) = _$ProfessionalImpl;
  const _Professional._() : super._();

  factory _Professional.fromJson(Map<String, dynamic> json) =
      _$ProfessionalImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'name_pro')
  String get namePro;
  @override
  @JsonKey(name: 'description')
  String get description;
  @override
  String? get service;
  @override
  Position? get position;
  @override
  String? get cover;
  @override
  @JsonKey(name: 'nombre_reservation')
  int get nombreReservation;
  @override
  @JsonKey(name: 'nombre_catalogue')
  int get nombreCatalogue;
  @override
  @JsonKey(name: 'nombre_actes')
  int get nombreActes;

  /// Create a copy of Professional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfessionalImplCopyWith<_$ProfessionalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Position _$PositionFromJson(Map<String, dynamic> json) {
  return _Position.fromJson(json);
}

/// @nodoc
mixin _$Position {
  @JsonKey(name: 'title_emplacement')
  String? get titleEmplacement => throw _privateConstructorUsedError;
  String? get longitude => throw _privateConstructorUsedError;
  String? get latitude => throw _privateConstructorUsedError;
  String? get town => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;

  /// Serializes this Position to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PositionCopyWith<Position> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PositionCopyWith<$Res> {
  factory $PositionCopyWith(Position value, $Res Function(Position) then) =
      _$PositionCopyWithImpl<$Res, Position>;
  @useResult
  $Res call(
      {@JsonKey(name: 'title_emplacement') String? titleEmplacement,
      String? longitude,
      String? latitude,
      String? town,
      String? country});
}

/// @nodoc
class _$PositionCopyWithImpl<$Res, $Val extends Position>
    implements $PositionCopyWith<$Res> {
  _$PositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleEmplacement = freezed,
    Object? longitude = freezed,
    Object? latitude = freezed,
    Object? town = freezed,
    Object? country = freezed,
  }) {
    return _then(_value.copyWith(
      titleEmplacement: freezed == titleEmplacement
          ? _value.titleEmplacement
          : titleEmplacement // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String?,
      town: freezed == town
          ? _value.town
          : town // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PositionImplCopyWith<$Res>
    implements $PositionCopyWith<$Res> {
  factory _$$PositionImplCopyWith(
          _$PositionImpl value, $Res Function(_$PositionImpl) then) =
      __$$PositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'title_emplacement') String? titleEmplacement,
      String? longitude,
      String? latitude,
      String? town,
      String? country});
}

/// @nodoc
class __$$PositionImplCopyWithImpl<$Res>
    extends _$PositionCopyWithImpl<$Res, _$PositionImpl>
    implements _$$PositionImplCopyWith<$Res> {
  __$$PositionImplCopyWithImpl(
      _$PositionImpl _value, $Res Function(_$PositionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleEmplacement = freezed,
    Object? longitude = freezed,
    Object? latitude = freezed,
    Object? town = freezed,
    Object? country = freezed,
  }) {
    return _then(_$PositionImpl(
      titleEmplacement: freezed == titleEmplacement
          ? _value.titleEmplacement
          : titleEmplacement // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String?,
      town: freezed == town
          ? _value.town
          : town // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PositionImpl extends _Position {
  const _$PositionImpl(
      {@JsonKey(name: 'title_emplacement') this.titleEmplacement,
      this.longitude,
      this.latitude,
      this.town,
      this.country})
      : super._();

  factory _$PositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PositionImplFromJson(json);

  @override
  @JsonKey(name: 'title_emplacement')
  final String? titleEmplacement;
  @override
  final String? longitude;
  @override
  final String? latitude;
  @override
  final String? town;
  @override
  final String? country;

  @override
  String toString() {
    return 'Position(titleEmplacement: $titleEmplacement, longitude: $longitude, latitude: $latitude, town: $town, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PositionImpl &&
            (identical(other.titleEmplacement, titleEmplacement) ||
                other.titleEmplacement == titleEmplacement) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.town, town) || other.town == town) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, titleEmplacement, longitude, latitude, town, country);

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PositionImplCopyWith<_$PositionImpl> get copyWith =>
      __$$PositionImplCopyWithImpl<_$PositionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PositionImplToJson(
      this,
    );
  }
}

abstract class _Position extends Position {
  const factory _Position(
      {@JsonKey(name: 'title_emplacement') final String? titleEmplacement,
      final String? longitude,
      final String? latitude,
      final String? town,
      final String? country}) = _$PositionImpl;
  const _Position._() : super._();

  factory _Position.fromJson(Map<String, dynamic> json) =
      _$PositionImpl.fromJson;

  @override
  @JsonKey(name: 'title_emplacement')
  String? get titleEmplacement;
  @override
  String? get longitude;
  @override
  String? get latitude;
  @override
  String? get town;
  @override
  String? get country;

  /// Create a copy of Position
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PositionImplCopyWith<_$PositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
