// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'status_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StatusEntity _$StatusEntityFromJson(Map<String, dynamic> json) {
  return _StatusEntity.fromJson(json);
}

/// @nodoc
mixin _$StatusEntity {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatusEntityCopyWith<StatusEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusEntityCopyWith<$Res> {
  factory $StatusEntityCopyWith(
          StatusEntity value, $Res Function(StatusEntity) then) =
      _$StatusEntityCopyWithImpl<$Res, StatusEntity>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$StatusEntityCopyWithImpl<$Res, $Val extends StatusEntity>
    implements $StatusEntityCopyWith<$Res> {
  _$StatusEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StatusEntityCopyWith<$Res>
    implements $StatusEntityCopyWith<$Res> {
  factory _$$_StatusEntityCopyWith(
          _$_StatusEntity value, $Res Function(_$_StatusEntity) then) =
      __$$_StatusEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$_StatusEntityCopyWithImpl<$Res>
    extends _$StatusEntityCopyWithImpl<$Res, _$_StatusEntity>
    implements _$$_StatusEntityCopyWith<$Res> {
  __$$_StatusEntityCopyWithImpl(
      _$_StatusEntity _value, $Res Function(_$_StatusEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_StatusEntity(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StatusEntity implements _StatusEntity {
  const _$_StatusEntity({this.id, this.name});

  factory _$_StatusEntity.fromJson(Map<String, dynamic> json) =>
      _$$_StatusEntityFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'StatusEntity(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StatusEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StatusEntityCopyWith<_$_StatusEntity> get copyWith =>
      __$$_StatusEntityCopyWithImpl<_$_StatusEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StatusEntityToJson(
      this,
    );
  }
}

abstract class _StatusEntity implements StatusEntity {
  const factory _StatusEntity({final int? id, final String? name}) =
      _$_StatusEntity;

  factory _StatusEntity.fromJson(Map<String, dynamic> json) =
      _$_StatusEntity.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_StatusEntityCopyWith<_$_StatusEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
