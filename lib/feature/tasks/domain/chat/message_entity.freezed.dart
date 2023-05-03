// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageEntity _$MessageEntityFromJson(Map<String, dynamic> json) {
  return _MessageEntity.fromJson(json);
}

/// @nodoc
mixin _$MessageEntity {
  int get id => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  DateTime get sentTo => throw _privateConstructorUsedError;
  int? get idTask => throw _privateConstructorUsedError;
  UserEntity? get user => throw _privateConstructorUsedError;
  TaskEntity? get task => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageEntityCopyWith<MessageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageEntityCopyWith<$Res> {
  factory $MessageEntityCopyWith(
          MessageEntity value, $Res Function(MessageEntity) then) =
      _$MessageEntityCopyWithImpl<$Res, MessageEntity>;
  @useResult
  $Res call(
      {int id,
      String? content,
      String? imageUrl,
      DateTime sentTo,
      int? idTask,
      UserEntity? user,
      TaskEntity? task});

  $UserEntityCopyWith<$Res>? get user;
  $TaskEntityCopyWith<$Res>? get task;
}

/// @nodoc
class _$MessageEntityCopyWithImpl<$Res, $Val extends MessageEntity>
    implements $MessageEntityCopyWith<$Res> {
  _$MessageEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = freezed,
    Object? imageUrl = freezed,
    Object? sentTo = null,
    Object? idTask = freezed,
    Object? user = freezed,
    Object? task = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      sentTo: null == sentTo
          ? _value.sentTo
          : sentTo // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
abstract class _$$_MessageEntityCopyWith<$Res>
    implements $MessageEntityCopyWith<$Res> {
  factory _$$_MessageEntityCopyWith(
          _$_MessageEntity value, $Res Function(_$_MessageEntity) then) =
      __$$_MessageEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? content,
      String? imageUrl,
      DateTime sentTo,
      int? idTask,
      UserEntity? user,
      TaskEntity? task});

  @override
  $UserEntityCopyWith<$Res>? get user;
  @override
  $TaskEntityCopyWith<$Res>? get task;
}

/// @nodoc
class __$$_MessageEntityCopyWithImpl<$Res>
    extends _$MessageEntityCopyWithImpl<$Res, _$_MessageEntity>
    implements _$$_MessageEntityCopyWith<$Res> {
  __$$_MessageEntityCopyWithImpl(
      _$_MessageEntity _value, $Res Function(_$_MessageEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = freezed,
    Object? imageUrl = freezed,
    Object? sentTo = null,
    Object? idTask = freezed,
    Object? user = freezed,
    Object? task = freezed,
  }) {
    return _then(_$_MessageEntity(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      sentTo: null == sentTo
          ? _value.sentTo
          : sentTo // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
class _$_MessageEntity implements _MessageEntity {
  const _$_MessageEntity(
      {required this.id,
      this.content,
      this.imageUrl,
      required this.sentTo,
      this.idTask,
      this.user,
      this.task});

  factory _$_MessageEntity.fromJson(Map<String, dynamic> json) =>
      _$$_MessageEntityFromJson(json);

  @override
  final int id;
  @override
  final String? content;
  @override
  final String? imageUrl;
  @override
  final DateTime sentTo;
  @override
  final int? idTask;
  @override
  final UserEntity? user;
  @override
  final TaskEntity? task;

  @override
  String toString() {
    return 'MessageEntity(id: $id, content: $content, imageUrl: $imageUrl, sentTo: $sentTo, idTask: $idTask, user: $user, task: $task)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.sentTo, sentTo) || other.sentTo == sentTo) &&
            (identical(other.idTask, idTask) || other.idTask == idTask) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.task, task) || other.task == task));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, content, imageUrl, sentTo, idTask, user, task);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageEntityCopyWith<_$_MessageEntity> get copyWith =>
      __$$_MessageEntityCopyWithImpl<_$_MessageEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageEntityToJson(
      this,
    );
  }
}

abstract class _MessageEntity implements MessageEntity {
  const factory _MessageEntity(
      {required final int id,
      final String? content,
      final String? imageUrl,
      required final DateTime sentTo,
      final int? idTask,
      final UserEntity? user,
      final TaskEntity? task}) = _$_MessageEntity;

  factory _MessageEntity.fromJson(Map<String, dynamic> json) =
      _$_MessageEntity.fromJson;

  @override
  int get id;
  @override
  String? get content;
  @override
  String? get imageUrl;
  @override
  DateTime get sentTo;
  @override
  int? get idTask;
  @override
  UserEntity? get user;
  @override
  TaskEntity? get task;
  @override
  @JsonKey(ignore: true)
  _$$_MessageEntityCopyWith<_$_MessageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
