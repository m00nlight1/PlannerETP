// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'author_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthorEntity _$AuthorEntityFromJson(Map<String, dynamic> json) {
  return _AuthorEntity.fromJson(json);
}

/// @nodoc
mixin _$AuthorEntity {
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthorEntityCopyWith<AuthorEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthorEntityCopyWith<$Res> {
  factory $AuthorEntityCopyWith(
          AuthorEntity value, $Res Function(AuthorEntity) then) =
      _$AuthorEntityCopyWithImpl<$Res, AuthorEntity>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class _$AuthorEntityCopyWithImpl<$Res, $Val extends AuthorEntity>
    implements $AuthorEntityCopyWith<$Res> {
  _$AuthorEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthorEntityCopyWith<$Res>
    implements $AuthorEntityCopyWith<$Res> {
  factory _$$_AuthorEntityCopyWith(
          _$_AuthorEntity value, $Res Function(_$_AuthorEntity) then) =
      __$$_AuthorEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$_AuthorEntityCopyWithImpl<$Res>
    extends _$AuthorEntityCopyWithImpl<$Res, _$_AuthorEntity>
    implements _$$_AuthorEntityCopyWith<$Res> {
  __$$_AuthorEntityCopyWithImpl(
      _$_AuthorEntity _value, $Res Function(_$_AuthorEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$_AuthorEntity(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuthorEntity implements _AuthorEntity {
  const _$_AuthorEntity({required this.id});

  factory _$_AuthorEntity.fromJson(Map<String, dynamic> json) =>
      _$$_AuthorEntityFromJson(json);

  @override
  final int id;

  @override
  String toString() {
    return 'AuthorEntity(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthorEntity &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthorEntityCopyWith<_$_AuthorEntity> get copyWith =>
      __$$_AuthorEntityCopyWithImpl<_$_AuthorEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthorEntityToJson(
      this,
    );
  }
}

abstract class _AuthorEntity implements AuthorEntity {
  const factory _AuthorEntity({required final int id}) = _$_AuthorEntity;

  factory _AuthorEntity.fromJson(Map<String, dynamic> json) =
      _$_AuthorEntity.fromJson;

  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$_AuthorEntityCopyWith<_$_AuthorEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
