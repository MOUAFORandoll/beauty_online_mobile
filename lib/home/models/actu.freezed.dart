// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'actu.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Actu _$ActuFromJson(Map<String, dynamic> json) {
  return _Actu.fromJson(json);
}

/// @nodoc
mixin _$Actu {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_professionnel')
  Professional get profileProfessionnel => throw _privateConstructorUsedError;
  @JsonKey(name: 'realisation_files')
  List<RealisationFile> get realisationFiles =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'nombre_vues')
  int get nombreVues => throw _privateConstructorUsedError;
  @JsonKey(name: 'nombre_likes')
  int get nombreLikes => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_liked')
  bool get hasLiked => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_video')
  bool? get isVideo => throw _privateConstructorUsedError;
  @JsonKey(name: 'video')
  Video? get video => throw _privateConstructorUsedError;
  @JsonKey(name: 'nombre_partages')
  int get nombrePartages => throw _privateConstructorUsedError;

  /// Serializes this Actu to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Actu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActuCopyWith<Actu> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActuCopyWith<$Res> {
  factory $ActuCopyWith(Actu value, $Res Function(Actu) then) =
      _$ActuCopyWithImpl<$Res, Actu>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? price,
      @JsonKey(name: 'profile_professionnel') Professional profileProfessionnel,
      @JsonKey(name: 'realisation_files')
      List<RealisationFile> realisationFiles,
      @JsonKey(name: 'nombre_vues') int nombreVues,
      @JsonKey(name: 'nombre_likes') int nombreLikes,
      @JsonKey(name: 'has_liked') bool hasLiked,
      @JsonKey(name: 'is_video') bool? isVideo,
      @JsonKey(name: 'video') Video? video,
      @JsonKey(name: 'nombre_partages') int nombrePartages});

  $ProfessionalCopyWith<$Res> get profileProfessionnel;
  $VideoCopyWith<$Res>? get video;
}

/// @nodoc
class _$ActuCopyWithImpl<$Res, $Val extends Actu>
    implements $ActuCopyWith<$Res> {
  _$ActuCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Actu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? price = freezed,
    Object? profileProfessionnel = null,
    Object? realisationFiles = null,
    Object? nombreVues = null,
    Object? nombreLikes = null,
    Object? hasLiked = null,
    Object? isVideo = freezed,
    Object? video = freezed,
    Object? nombrePartages = null,
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
      profileProfessionnel: null == profileProfessionnel
          ? _value.profileProfessionnel
          : profileProfessionnel // ignore: cast_nullable_to_non_nullable
              as Professional,
      realisationFiles: null == realisationFiles
          ? _value.realisationFiles
          : realisationFiles // ignore: cast_nullable_to_non_nullable
              as List<RealisationFile>,
      nombreVues: null == nombreVues
          ? _value.nombreVues
          : nombreVues // ignore: cast_nullable_to_non_nullable
              as int,
      nombreLikes: null == nombreLikes
          ? _value.nombreLikes
          : nombreLikes // ignore: cast_nullable_to_non_nullable
              as int,
      hasLiked: null == hasLiked
          ? _value.hasLiked
          : hasLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      isVideo: freezed == isVideo
          ? _value.isVideo
          : isVideo // ignore: cast_nullable_to_non_nullable
              as bool?,
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as Video?,
      nombrePartages: null == nombrePartages
          ? _value.nombrePartages
          : nombrePartages // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of Actu
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfessionalCopyWith<$Res> get profileProfessionnel {
    return $ProfessionalCopyWith<$Res>(_value.profileProfessionnel, (value) {
      return _then(_value.copyWith(profileProfessionnel: value) as $Val);
    });
  }

  /// Create a copy of Actu
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
abstract class _$$ActuImplCopyWith<$Res> implements $ActuCopyWith<$Res> {
  factory _$$ActuImplCopyWith(
          _$ActuImpl value, $Res Function(_$ActuImpl) then) =
      __$$ActuImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? price,
      @JsonKey(name: 'profile_professionnel') Professional profileProfessionnel,
      @JsonKey(name: 'realisation_files')
      List<RealisationFile> realisationFiles,
      @JsonKey(name: 'nombre_vues') int nombreVues,
      @JsonKey(name: 'nombre_likes') int nombreLikes,
      @JsonKey(name: 'has_liked') bool hasLiked,
      @JsonKey(name: 'is_video') bool? isVideo,
      @JsonKey(name: 'video') Video? video,
      @JsonKey(name: 'nombre_partages') int nombrePartages});

  @override
  $ProfessionalCopyWith<$Res> get profileProfessionnel;
  @override
  $VideoCopyWith<$Res>? get video;
}

/// @nodoc
class __$$ActuImplCopyWithImpl<$Res>
    extends _$ActuCopyWithImpl<$Res, _$ActuImpl>
    implements _$$ActuImplCopyWith<$Res> {
  __$$ActuImplCopyWithImpl(_$ActuImpl _value, $Res Function(_$ActuImpl) _then)
      : super(_value, _then);

  /// Create a copy of Actu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? price = freezed,
    Object? profileProfessionnel = null,
    Object? realisationFiles = null,
    Object? nombreVues = null,
    Object? nombreLikes = null,
    Object? hasLiked = null,
    Object? isVideo = freezed,
    Object? video = freezed,
    Object? nombrePartages = null,
  }) {
    return _then(_$ActuImpl(
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
      profileProfessionnel: null == profileProfessionnel
          ? _value.profileProfessionnel
          : profileProfessionnel // ignore: cast_nullable_to_non_nullable
              as Professional,
      realisationFiles: null == realisationFiles
          ? _value._realisationFiles
          : realisationFiles // ignore: cast_nullable_to_non_nullable
              as List<RealisationFile>,
      nombreVues: null == nombreVues
          ? _value.nombreVues
          : nombreVues // ignore: cast_nullable_to_non_nullable
              as int,
      nombreLikes: null == nombreLikes
          ? _value.nombreLikes
          : nombreLikes // ignore: cast_nullable_to_non_nullable
              as int,
      hasLiked: null == hasLiked
          ? _value.hasLiked
          : hasLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      isVideo: freezed == isVideo
          ? _value.isVideo
          : isVideo // ignore: cast_nullable_to_non_nullable
              as bool?,
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as Video?,
      nombrePartages: null == nombrePartages
          ? _value.nombrePartages
          : nombrePartages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActuImpl implements _Actu {
  const _$ActuImpl(
      {required this.id,
      required this.title,
      this.price,
      @JsonKey(name: 'profile_professionnel')
      required this.profileProfessionnel,
      @JsonKey(name: 'realisation_files')
      required final List<RealisationFile> realisationFiles,
      @JsonKey(name: 'nombre_vues') required this.nombreVues,
      @JsonKey(name: 'nombre_likes') required this.nombreLikes,
      @JsonKey(name: 'has_liked') required this.hasLiked,
      @JsonKey(name: 'is_video') this.isVideo,
      @JsonKey(name: 'video') this.video,
      @JsonKey(name: 'nombre_partages') required this.nombrePartages})
      : _realisationFiles = realisationFiles;

  factory _$ActuImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActuImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? price;
  @override
  @JsonKey(name: 'profile_professionnel')
  final Professional profileProfessionnel;
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
  @JsonKey(name: 'nombre_vues')
  final int nombreVues;
  @override
  @JsonKey(name: 'nombre_likes')
  final int nombreLikes;
  @override
  @JsonKey(name: 'has_liked')
  final bool hasLiked;
  @override
  @JsonKey(name: 'is_video')
  final bool? isVideo;
  @override
  @JsonKey(name: 'video')
  final Video? video;
  @override
  @JsonKey(name: 'nombre_partages')
  final int nombrePartages;

  @override
  String toString() {
    return 'Actu(id: $id, title: $title, price: $price, profileProfessionnel: $profileProfessionnel, realisationFiles: $realisationFiles, nombreVues: $nombreVues, nombreLikes: $nombreLikes, hasLiked: $hasLiked, isVideo: $isVideo, video: $video, nombrePartages: $nombrePartages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActuImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.profileProfessionnel, profileProfessionnel) ||
                other.profileProfessionnel == profileProfessionnel) &&
            const DeepCollectionEquality()
                .equals(other._realisationFiles, _realisationFiles) &&
            (identical(other.nombreVues, nombreVues) ||
                other.nombreVues == nombreVues) &&
            (identical(other.nombreLikes, nombreLikes) ||
                other.nombreLikes == nombreLikes) &&
            (identical(other.hasLiked, hasLiked) ||
                other.hasLiked == hasLiked) &&
            (identical(other.isVideo, isVideo) || other.isVideo == isVideo) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.nombrePartages, nombrePartages) ||
                other.nombrePartages == nombrePartages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      price,
      profileProfessionnel,
      const DeepCollectionEquality().hash(_realisationFiles),
      nombreVues,
      nombreLikes,
      hasLiked,
      isVideo,
      video,
      nombrePartages);

  /// Create a copy of Actu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActuImplCopyWith<_$ActuImpl> get copyWith =>
      __$$ActuImplCopyWithImpl<_$ActuImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActuImplToJson(
      this,
    );
  }
}

abstract class _Actu implements Actu {
  const factory _Actu(
      {required final String id,
      required final String title,
      final String? price,
      @JsonKey(name: 'profile_professionnel')
      required final Professional profileProfessionnel,
      @JsonKey(name: 'realisation_files')
      required final List<RealisationFile> realisationFiles,
      @JsonKey(name: 'nombre_vues') required final int nombreVues,
      @JsonKey(name: 'nombre_likes') required final int nombreLikes,
      @JsonKey(name: 'has_liked') required final bool hasLiked,
      @JsonKey(name: 'is_video') final bool? isVideo,
      @JsonKey(name: 'video') final Video? video,
      @JsonKey(name: 'nombre_partages')
      required final int nombrePartages}) = _$ActuImpl;

  factory _Actu.fromJson(Map<String, dynamic> json) = _$ActuImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get price;
  @override
  @JsonKey(name: 'profile_professionnel')
  Professional get profileProfessionnel;
  @override
  @JsonKey(name: 'realisation_files')
  List<RealisationFile> get realisationFiles;
  @override
  @JsonKey(name: 'nombre_vues')
  int get nombreVues;
  @override
  @JsonKey(name: 'nombre_likes')
  int get nombreLikes;
  @override
  @JsonKey(name: 'has_liked')
  bool get hasLiked;
  @override
  @JsonKey(name: 'is_video')
  bool? get isVideo;
  @override
  @JsonKey(name: 'video')
  Video? get video;
  @override
  @JsonKey(name: 'nombre_partages')
  int get nombrePartages;

  /// Create a copy of Actu
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActuImplCopyWith<_$ActuImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
