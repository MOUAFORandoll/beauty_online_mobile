// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalogue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Catalogue _$CatalogueFromJson(Map<String, dynamic> json) {
  return _Catalogue.fromJson(json);
}

/// @nodoc
mixin _$Catalogue {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_professionnel_id')
  String get profileProfessionnelId => throw _privateConstructorUsedError;
  @JsonKey(name: 'realisation_files')
  List<RealisationFile> get realisationFiles =>
      throw _privateConstructorUsedError;

  /// Serializes this Catalogue to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Catalogue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogueCopyWith<Catalogue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogueCopyWith<$Res> {
  factory $CatalogueCopyWith(Catalogue value, $Res Function(Catalogue) then) =
      _$CatalogueCopyWithImpl<$Res, Catalogue>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? price,
      @JsonKey(name: 'profile_professionnel_id') String profileProfessionnelId,
      @JsonKey(name: 'realisation_files')
      List<RealisationFile> realisationFiles});
}

/// @nodoc
class _$CatalogueCopyWithImpl<$Res, $Val extends Catalogue>
    implements $CatalogueCopyWith<$Res> {
  _$CatalogueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Catalogue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? price = freezed,
    Object? profileProfessionnelId = null,
    Object? realisationFiles = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      profileProfessionnelId: null == profileProfessionnelId
          ? _value.profileProfessionnelId
          : profileProfessionnelId // ignore: cast_nullable_to_non_nullable
              as String,
      realisationFiles: null == realisationFiles
          ? _value.realisationFiles
          : realisationFiles // ignore: cast_nullable_to_non_nullable
              as List<RealisationFile>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CatalogueImplCopyWith<$Res>
    implements $CatalogueCopyWith<$Res> {
  factory _$$CatalogueImplCopyWith(
          _$CatalogueImpl value, $Res Function(_$CatalogueImpl) then) =
      __$$CatalogueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? price,
      @JsonKey(name: 'profile_professionnel_id') String profileProfessionnelId,
      @JsonKey(name: 'realisation_files')
      List<RealisationFile> realisationFiles});
}

/// @nodoc
class __$$CatalogueImplCopyWithImpl<$Res>
    extends _$CatalogueCopyWithImpl<$Res, _$CatalogueImpl>
    implements _$$CatalogueImplCopyWith<$Res> {
  __$$CatalogueImplCopyWithImpl(
      _$CatalogueImpl _value, $Res Function(_$CatalogueImpl) _then)
      : super(_value, _then);

  /// Create a copy of Catalogue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? price = freezed,
    Object? profileProfessionnelId = null,
    Object? realisationFiles = null,
  }) {
    return _then(_$CatalogueImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      profileProfessionnelId: null == profileProfessionnelId
          ? _value.profileProfessionnelId
          : profileProfessionnelId // ignore: cast_nullable_to_non_nullable
              as String,
      realisationFiles: null == realisationFiles
          ? _value._realisationFiles
          : realisationFiles // ignore: cast_nullable_to_non_nullable
              as List<RealisationFile>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CatalogueImpl extends _Catalogue {
  const _$CatalogueImpl(
      {required this.id,
      required this.title,
      this.price,
      @JsonKey(name: 'profile_professionnel_id')
      required this.profileProfessionnelId,
      @JsonKey(name: 'realisation_files')
      required final List<RealisationFile> realisationFiles})
      : _realisationFiles = realisationFiles,
        super._();

  factory _$CatalogueImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatalogueImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? price;
  @override
  @JsonKey(name: 'profile_professionnel_id')
  final String profileProfessionnelId;
  final List<RealisationFile> _realisationFiles;
  @override
  @JsonKey(name: 'realisation_files')
  List<RealisationFile> get realisationFiles {
    if (_realisationFiles is EqualUnmodifiableListView)
      return _realisationFiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_realisationFiles);
  }

  @override
  String toString() {
    return 'Catalogue(id: $id, title: $title, price: $price, profileProfessionnelId: $profileProfessionnelId, realisationFiles: $realisationFiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.profileProfessionnelId, profileProfessionnelId) ||
                other.profileProfessionnelId == profileProfessionnelId) &&
            const DeepCollectionEquality()
                .equals(other._realisationFiles, _realisationFiles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      price,
      profileProfessionnelId,
      const DeepCollectionEquality().hash(_realisationFiles));

  /// Create a copy of Catalogue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogueImplCopyWith<_$CatalogueImpl> get copyWith =>
      __$$CatalogueImplCopyWithImpl<_$CatalogueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CatalogueImplToJson(
      this,
    );
  }
}

abstract class _Catalogue extends Catalogue {
  const factory _Catalogue(
      {required final String id,
      required final String title,
      final String? price,
      @JsonKey(name: 'profile_professionnel_id')
      required final String profileProfessionnelId,
      @JsonKey(name: 'realisation_files')
      required final List<RealisationFile> realisationFiles}) = _$CatalogueImpl;
  const _Catalogue._() : super._();

  factory _Catalogue.fromJson(Map<String, dynamic> json) =
      _$CatalogueImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get price;
  @override
  @JsonKey(name: 'profile_professionnel_id')
  String get profileProfessionnelId;
  @override
  @JsonKey(name: 'realisation_files')
  List<RealisationFile> get realisationFiles;

  /// Create a copy of Catalogue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogueImplCopyWith<_$CatalogueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RealisationFile _$RealisationFileFromJson(Map<String, dynamic> json) {
  return _RealisationFile.fromJson(json);
}

/// @nodoc
mixin _$RealisationFile {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_path')
  String get filePath => throw _privateConstructorUsedError;

  /// Serializes this RealisationFile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RealisationFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RealisationFileCopyWith<RealisationFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RealisationFileCopyWith<$Res> {
  factory $RealisationFileCopyWith(
          RealisationFile value, $Res Function(RealisationFile) then) =
      _$RealisationFileCopyWithImpl<$Res, RealisationFile>;
  @useResult
  $Res call({String id, @JsonKey(name: 'file_path') String filePath});
}

/// @nodoc
class _$RealisationFileCopyWithImpl<$Res, $Val extends RealisationFile>
    implements $RealisationFileCopyWith<$Res> {
  _$RealisationFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RealisationFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? filePath = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RealisationFileImplCopyWith<$Res>
    implements $RealisationFileCopyWith<$Res> {
  factory _$$RealisationFileImplCopyWith(_$RealisationFileImpl value,
          $Res Function(_$RealisationFileImpl) then) =
      __$$RealisationFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, @JsonKey(name: 'file_path') String filePath});
}

/// @nodoc
class __$$RealisationFileImplCopyWithImpl<$Res>
    extends _$RealisationFileCopyWithImpl<$Res, _$RealisationFileImpl>
    implements _$$RealisationFileImplCopyWith<$Res> {
  __$$RealisationFileImplCopyWithImpl(
      _$RealisationFileImpl _value, $Res Function(_$RealisationFileImpl) _then)
      : super(_value, _then);

  /// Create a copy of RealisationFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? filePath = null,
  }) {
    return _then(_$RealisationFileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RealisationFileImpl extends _RealisationFile {
  const _$RealisationFileImpl(
      {required this.id, @JsonKey(name: 'file_path') required this.filePath})
      : super._();

  factory _$RealisationFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$RealisationFileImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'file_path')
  final String filePath;

  @override
  String toString() {
    return 'RealisationFile(id: $id, filePath: $filePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RealisationFileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, filePath);

  /// Create a copy of RealisationFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RealisationFileImplCopyWith<_$RealisationFileImpl> get copyWith =>
      __$$RealisationFileImplCopyWithImpl<_$RealisationFileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RealisationFileImplToJson(
      this,
    );
  }
}

abstract class _RealisationFile extends RealisationFile {
  const factory _RealisationFile(
          {required final String id,
          @JsonKey(name: 'file_path') required final String filePath}) =
      _$RealisationFileImpl;
  const _RealisationFile._() : super._();

  factory _RealisationFile.fromJson(Map<String, dynamic> json) =
      _$RealisationFileImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'file_path')
  String get filePath;

  /// Create a copy of RealisationFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RealisationFileImplCopyWith<_$RealisationFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
