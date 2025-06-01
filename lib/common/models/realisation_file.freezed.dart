// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'realisation_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
