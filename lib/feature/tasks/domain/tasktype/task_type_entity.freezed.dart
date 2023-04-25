// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_type_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskTypeEntity _$TaskTypeEntityFromJson(Map<String, dynamic> json) {
  return _TaskTypeEntity.fromJson(json);
}

/// @nodoc
mixin _$TaskTypeEntity {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskTypeEntityCopyWith<TaskTypeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskTypeEntityCopyWith<$Res> {
  factory $TaskTypeEntityCopyWith(
          TaskTypeEntity value, $Res Function(TaskTypeEntity) then) =
      _$TaskTypeEntityCopyWithImpl<$Res, TaskTypeEntity>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$TaskTypeEntityCopyWithImpl<$Res, $Val extends TaskTypeEntity>
    implements $TaskTypeEntityCopyWith<$Res> {
  _$TaskTypeEntityCopyWithImpl(this._value, this._then);

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
abstract class _$$_TaskTypeEntityCopyWith<$Res>
    implements $TaskTypeEntityCopyWith<$Res> {
  factory _$$_TaskTypeEntityCopyWith(
          _$_TaskTypeEntity value, $Res Function(_$_TaskTypeEntity) then) =
      __$$_TaskTypeEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$_TaskTypeEntityCopyWithImpl<$Res>
    extends _$TaskTypeEntityCopyWithImpl<$Res, _$_TaskTypeEntity>
    implements _$$_TaskTypeEntityCopyWith<$Res> {
  __$$_TaskTypeEntityCopyWithImpl(
      _$_TaskTypeEntity _value, $Res Function(_$_TaskTypeEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_TaskTypeEntity(
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
class _$_TaskTypeEntity implements _TaskTypeEntity {
  const _$_TaskTypeEntity({this.id, this.name});

  factory _$_TaskTypeEntity.fromJson(Map<String, dynamic> json) =>
      _$$_TaskTypeEntityFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'TaskTypeEntity(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskTypeEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskTypeEntityCopyWith<_$_TaskTypeEntity> get copyWith =>
      __$$_TaskTypeEntityCopyWithImpl<_$_TaskTypeEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskTypeEntityToJson(
      this,
    );
  }
}

abstract class _TaskTypeEntity implements TaskTypeEntity {
  const factory _TaskTypeEntity({final int? id, final String? name}) =
      _$_TaskTypeEntity;

  factory _TaskTypeEntity.fromJson(Map<String, dynamic> json) =
      _$_TaskTypeEntity.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_TaskTypeEntityCopyWith<_$_TaskTypeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
