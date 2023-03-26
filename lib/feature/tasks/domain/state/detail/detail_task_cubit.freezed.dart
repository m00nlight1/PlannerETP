// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_task_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DetailTaskState {
  AsyncSnapshot<dynamic> get asyncSnapshot =>
      throw _privateConstructorUsedError;
  TaskEntity? get taskEntity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DetailTaskStateCopyWith<DetailTaskState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailTaskStateCopyWith<$Res> {
  factory $DetailTaskStateCopyWith(
          DetailTaskState value, $Res Function(DetailTaskState) then) =
      _$DetailTaskStateCopyWithImpl<$Res, DetailTaskState>;
  @useResult
  $Res call({AsyncSnapshot<dynamic> asyncSnapshot, TaskEntity? taskEntity});

  $TaskEntityCopyWith<$Res>? get taskEntity;
}

/// @nodoc
class _$DetailTaskStateCopyWithImpl<$Res, $Val extends DetailTaskState>
    implements $DetailTaskStateCopyWith<$Res> {
  _$DetailTaskStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? asyncSnapshot = null,
    Object? taskEntity = freezed,
  }) {
    return _then(_value.copyWith(
      asyncSnapshot: null == asyncSnapshot
          ? _value.asyncSnapshot
          : asyncSnapshot // ignore: cast_nullable_to_non_nullable
              as AsyncSnapshot<dynamic>,
      taskEntity: freezed == taskEntity
          ? _value.taskEntity
          : taskEntity // ignore: cast_nullable_to_non_nullable
              as TaskEntity?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskEntityCopyWith<$Res>? get taskEntity {
    if (_value.taskEntity == null) {
      return null;
    }

    return $TaskEntityCopyWith<$Res>(_value.taskEntity!, (value) {
      return _then(_value.copyWith(taskEntity: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DetailTaskStateCopyWith<$Res>
    implements $DetailTaskStateCopyWith<$Res> {
  factory _$$_DetailTaskStateCopyWith(
          _$_DetailTaskState value, $Res Function(_$_DetailTaskState) then) =
      __$$_DetailTaskStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncSnapshot<dynamic> asyncSnapshot, TaskEntity? taskEntity});

  @override
  $TaskEntityCopyWith<$Res>? get taskEntity;
}

/// @nodoc
class __$$_DetailTaskStateCopyWithImpl<$Res>
    extends _$DetailTaskStateCopyWithImpl<$Res, _$_DetailTaskState>
    implements _$$_DetailTaskStateCopyWith<$Res> {
  __$$_DetailTaskStateCopyWithImpl(
      _$_DetailTaskState _value, $Res Function(_$_DetailTaskState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? asyncSnapshot = null,
    Object? taskEntity = freezed,
  }) {
    return _then(_$_DetailTaskState(
      asyncSnapshot: null == asyncSnapshot
          ? _value.asyncSnapshot
          : asyncSnapshot // ignore: cast_nullable_to_non_nullable
              as AsyncSnapshot<dynamic>,
      taskEntity: freezed == taskEntity
          ? _value.taskEntity
          : taskEntity // ignore: cast_nullable_to_non_nullable
              as TaskEntity?,
    ));
  }
}

/// @nodoc

class _$_DetailTaskState implements _DetailTaskState {
  const _$_DetailTaskState(
      {this.asyncSnapshot = const AsyncSnapshot.nothing(), this.taskEntity});

  @override
  @JsonKey()
  final AsyncSnapshot<dynamic> asyncSnapshot;
  @override
  final TaskEntity? taskEntity;

  @override
  String toString() {
    return 'DetailTaskState(asyncSnapshot: $asyncSnapshot, taskEntity: $taskEntity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DetailTaskState &&
            (identical(other.asyncSnapshot, asyncSnapshot) ||
                other.asyncSnapshot == asyncSnapshot) &&
            (identical(other.taskEntity, taskEntity) ||
                other.taskEntity == taskEntity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, asyncSnapshot, taskEntity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DetailTaskStateCopyWith<_$_DetailTaskState> get copyWith =>
      __$$_DetailTaskStateCopyWithImpl<_$_DetailTaskState>(this, _$identity);
}

abstract class _DetailTaskState implements DetailTaskState {
  const factory _DetailTaskState(
      {final AsyncSnapshot<dynamic> asyncSnapshot,
      final TaskEntity? taskEntity}) = _$_DetailTaskState;

  @override
  AsyncSnapshot<dynamic> get asyncSnapshot;
  @override
  TaskEntity? get taskEntity;
  @override
  @JsonKey(ignore: true)
  _$$_DetailTaskStateCopyWith<_$_DetailTaskState> get copyWith =>
      throw _privateConstructorUsedError;
}
