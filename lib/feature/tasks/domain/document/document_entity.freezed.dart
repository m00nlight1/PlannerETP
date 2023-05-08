// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DocumentEntity _$DocumentEntityFromJson(Map<String, dynamic> json) {
  return _DocumentEntity.fromJson(json);
}

/// @nodoc
mixin _$DocumentEntity {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  int? get idTask => throw _privateConstructorUsedError;
  UserEntity? get user => throw _privateConstructorUsedError;
  TaskEntity? get task => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentEntityCopyWith<DocumentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentEntityCopyWith<$Res> {
  factory $DocumentEntityCopyWith(
          DocumentEntity value, $Res Function(DocumentEntity) then) =
      _$DocumentEntityCopyWithImpl<$Res, DocumentEntity>;
  @useResult
  $Res call(
      {int id,
      String name,
      String filePath,
      int? idTask,
      UserEntity? user,
      TaskEntity? task});

  $UserEntityCopyWith<$Res>? get user;
  $TaskEntityCopyWith<$Res>? get task;
}

/// @nodoc
class _$DocumentEntityCopyWithImpl<$Res, $Val extends DocumentEntity>
    implements $DocumentEntityCopyWith<$Res> {
  _$DocumentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? filePath = null,
    Object? idTask = freezed,
    Object? user = freezed,
    Object? task = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      idTask: freezed == idTask
          ? _value.idTask
          : idTask // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
      task: freezed == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskEntity?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserEntityCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskEntityCopyWith<$Res>? get task {
    if (_value.task == null) {
      return null;
    }

    return $TaskEntityCopyWith<$Res>(_value.task!, (value) {
      return _then(_value.copyWith(task: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DocumentEntityCopyWith<$Res>
    implements $DocumentEntityCopyWith<$Res> {
  factory _$$_DocumentEntityCopyWith(
          _$_DocumentEntity value, $Res Function(_$_DocumentEntity) then) =
      __$$_DocumentEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String filePath,
      int? idTask,
      UserEntity? user,
      TaskEntity? task});

  @override
  $UserEntityCopyWith<$Res>? get user;
  @override
  $TaskEntityCopyWith<$Res>? get task;
}

/// @nodoc
class __$$_DocumentEntityCopyWithImpl<$Res>
    extends _$DocumentEntityCopyWithImpl<$Res, _$_DocumentEntity>
    implements _$$_DocumentEntityCopyWith<$Res> {
  __$$_DocumentEntityCopyWithImpl(
      _$_DocumentEntity _value, $Res Function(_$_DocumentEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? filePath = null,
    Object? idTask = freezed,
    Object? user = freezed,
    Object? task = freezed,
  }) {
    return _then(_$_DocumentEntity(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      idTask: freezed == idTask
          ? _value.idTask
          : idTask // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
      task: freezed == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskEntity?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DocumentEntity implements _DocumentEntity {
  const _$_DocumentEntity(
      {required this.id,
      required this.name,
      required this.filePath,
      this.idTask,
      this.user,
      this.task});

  factory _$_DocumentEntity.fromJson(Map<String, dynamic> json) =>
      _$$_DocumentEntityFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String filePath;
  @override
  final int? idTask;
  @override
  final UserEntity? user;
  @override
  final TaskEntity? task;

  @override
  String toString() {
    return 'DocumentEntity(id: $id, name: $name, filePath: $filePath, idTask: $idTask, user: $user, task: $task)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DocumentEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.idTask, idTask) || other.idTask == idTask) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.task, task) || other.task == task));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, filePath, idTask, user, task);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DocumentEntityCopyWith<_$_DocumentEntity> get copyWith =>
      __$$_DocumentEntityCopyWithImpl<_$_DocumentEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DocumentEntityToJson(
      this,
    );
  }
}

abstract class _DocumentEntity implements DocumentEntity {
  const factory _DocumentEntity(
      {required final int id,
      required final String name,
      required final String filePath,
      final int? idTask,
      final UserEntity? user,
      final TaskEntity? task}) = _$_DocumentEntity;

  factory _DocumentEntity.fromJson(Map<String, dynamic> json) =
      _$_DocumentEntity.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get filePath;
  @override
  int? get idTask;
  @override
  UserEntity? get user;
  @override
  TaskEntity? get task;
  @override
  @JsonKey(ignore: true)
  _$$_DocumentEntityCopyWith<_$_DocumentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
