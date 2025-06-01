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
  @JsonKey(name: 'is_video')
  bool? get isVideo => throw _privateConstructorUsedError;
  @JsonKey(name: 'video')
  Video? get video => throw _privateConstructorUsedError;

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
      List<RealisationFile> realisationFiles,
      @JsonKey(name: 'is_video') bool? isVideo,
      @JsonKey(name: 'video') Video? video});

  $VideoCopyWith<$Res>? get video;
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
    Object? isVideo = freezed,
    Object? video = freezed,
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
      isVideo: freezed == isVideo
          ? _value.isVideo
          : isVideo // ignore: cast_nullable_to_non_nullable
              as bool?,
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as Video?,
    ) as $Val);
  }

  /// Create a copy of Catalogue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VideoCopyWith<$Res>? get video {
    if (_value.video == null) {
      return null;
    }

    return $VideoCopyWith<$Res>(_value.video!, (value) {
      return _then(_value.copyWith(video: value) as $Val);
    });
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
      List<RealisationFile> realisationFiles,
      @JsonKey(name: 'is_video') bool? isVideo,
      @JsonKey(name: 'video') Video? video});

  @override
  $VideoCopyWith<$Res>? get video;
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
    Object? isVideo = freezed,
    Object? video = freezed,
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
      isVideo: freezed == isVideo
          ? _value.isVideo
          : isVideo // ignore: cast_nullable_to_non_nullable
              as bool?,
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as Video?,
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
      required final List<RealisationFile> realisationFiles,
      @JsonKey(name: 'is_video') this.isVideo,
      @JsonKey(name: 'video') this.video})
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
  @JsonKey(name: 'is_video')
  final bool? isVideo;
  @override
  @JsonKey(name: 'video')
  final Video? video;

  @override
  String toString() {
    return 'Catalogue(id: $id, title: $title, price: $price, profileProfessionnelId: $profileProfessionnelId, realisationFiles: $realisationFiles, isVideo: $isVideo, video: $video)';
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
                .equals(other._realisationFiles, _realisationFiles) &&
            (identical(other.isVideo, isVideo) || other.isVideo == isVideo) &&
            (identical(other.video, video) || other.video == video));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      price,
      profileProfessionnelId,
      const DeepCollectionEquality().hash(_realisationFiles),
      isVideo,
      video);

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
      required final List<RealisationFile> realisationFiles,
      @JsonKey(name: 'is_video') final bool? isVideo,
      @JsonKey(name: 'video') final Video? video}) = _$CatalogueImpl;
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
  @override
  @JsonKey(name: 'is_video')
  bool? get isVideo;
  @override
  @JsonKey(name: 'video')
  Video? get video;

  /// Create a copy of Catalogue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogueImplCopyWith<_$CatalogueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
