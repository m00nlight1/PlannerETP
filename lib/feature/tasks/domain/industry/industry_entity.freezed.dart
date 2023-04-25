// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'industry_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IndustryEntity _$IndustryEntityFromJson(Map<String, dynamic> json) {
  return _IndustryEntity.fromJson(json);
}

/// @nodoc
mixin _$IndustryEntity {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IndustryEntityCopyWith<IndustryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IndustryEntityCopyWith<$Res> {
  factory $IndustryEntityCopyWith(
          IndustryEntity value, $Res Function(IndustryEntity) then) =
      _$IndustryEntityCopyWithImpl<$Res, IndustryEntity>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$IndustryEntityCopyWithImpl<$Res, $Val extends IndustryEntity>
    implements $IndustryEntityCopyWith<$Res> {
  _$IndustryEntityCopyWithImpl(this._value, this._then);

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
abstract class _$$_IndustryEntityCopyWith<$Res>
    implements $IndustryEntityCopyWith<$Res> {
  factory _$$_IndustryEntityCopyWith(
          _$_IndustryEntity value, $Res Function(_$_IndustryEntity) then) =
      __$$_IndustryEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$_IndustryEntityCopyWithImpl<$Res>
    extends _$IndustryEntityCopyWithImpl<$Res, _$_IndustryEntity>
    implements _$$_IndustryEntityCopyWith<$Res> {
  __$$_IndustryEntityCopyWithImpl(
      _$_IndustryEntity _value, $Res Function(_$_IndustryEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_IndustryEntity(
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
class _$_IndustryEntity implements _IndustryEntity {
  const _$_IndustryEntity({this.id, this.name});

  factory _$_IndustryEntity.fromJson(Map<String, dynamic> json) =>
      _$$_IndustryEntityFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'IndustryEntity(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IndustryEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IndustryEntityCopyWith<_$_IndustryEntity> get copyWith =>
      __$$_IndustryEntityCopyWithImpl<_$_IndustryEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IndustryEntityToJson(
      this,
    );
  }
}

abstract class _IndustryEntity implements IndustryEntity {
  const factory _IndustryEntity({final int? id, final String? name}) =
      _$_IndustryEntity;

  factory _IndustryEntity.fromJson(Map<String, dynamic> json) =
      _$_IndustryEntity.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_IndustryEntityCopyWith<_$_IndustryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
