// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskState _$TaskStateFromJson(Map<String, dynamic> json) {
  return _TaskState.fromJson(json);
}

/// @nodoc
mixin _$TaskState {
  @JsonKey(ignore: true)
  AsyncSnapshot<dynamic>? get asyncSnapshot =>
      throw _privateConstructorUsedError;
  List<TaskEntity> get taskList => throw _privateConstructorUsedError;
  List<StatusEntity> get statusList => throw _privateConstructorUsedError;
  List<TaskTypeEntity> get taskTypeList => throw _privateConstructorUsedError;
  List<IndustryEntity> get industryList => throw _privateConstructorUsedError;
  List<DocumentEntity> get docList => throw _privateConstructorUsedError;
  List<MessageEntity> get chatsList => throw _privateConstructorUsedError;
  List<UserEntity> get usersList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskStateCopyWith<TaskState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskStateCopyWith<$Res> {
  factory $TaskStateCopyWith(TaskState value, $Res Function(TaskState) then) =
      _$TaskStateCopyWithImpl<$Res, TaskState>;
  @useResult
  $Res call(
      {@JsonKey(ignore: true) AsyncSnapshot<dynamic>? asyncSnapshot,
      List<TaskEntity> taskList,
      List<StatusEntity> statusList,
      List<TaskTypeEntity> taskTypeList,
      List<IndustryEntity> industryList,
      List<DocumentEntity> docList,
      List<MessageEntity> chatsList,
      List<UserEntity> usersList});
}

/// @nodoc
class _$TaskStateCopyWithImpl<$Res, $Val extends TaskState>
    implements $TaskStateCopyWith<$Res> {
  _$TaskStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? asyncSnapshot = freezed,
    Object? taskList = null,
    Object? statusList = null,
    Object? taskTypeList = null,
    Object? industryList = null,
    Object? docList = null,
    Object? chatsList = null,
    Object? usersList = null,
  }) {
    return _then(_value.copyWith(
      asyncSnapshot: freezed == asyncSnapshot
          ? _value.asyncSnapshot
          : asyncSnapshot // ignore: cast_nullable_to_non_nullable
              as AsyncSnapshot<dynamic>?,
      taskList: null == taskList
          ? _value.taskList
          : taskList // ignore: cast_nullable_to_non_nullable
              as List<TaskEntity>,
      statusList: null == statusList
          ? _value.statusList
          : statusList // ignore: cast_nullable_to_non_nullable
              as List<StatusEntity>,
      taskTypeList: null == taskTypeList
          ? _value.taskTypeList
          : taskTypeList // ignore: cast_nullable_to_non_nullable
              as List<TaskTypeEntity>,
      industryList: null == industryList
          ? _value.industryList
          : industryList // ignore: cast_nullable_to_non_nullable
              as List<IndustryEntity>,
      docList: null == docList
          ? _value.docList
          : docList // ignore: cast_nullable_to_non_nullable
              as List<DocumentEntity>,
      chatsList: null == chatsList
          ? _value.chatsList
          : chatsList // ignore: cast_nullable_to_non_nullable
              as List<MessageEntity>,
      usersList: null == usersList
          ? _value.usersList
          : usersList // ignore: cast_nullable_to_non_nullable
              as List<UserEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskStateCopyWith<$Res> implements $TaskStateCopyWith<$Res> {
  factory _$$_TaskStateCopyWith(
          _$_TaskState value, $Res Function(_$_TaskState) then) =
      __$$_TaskStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(ignore: true) AsyncSnapshot<dynamic>? asyncSnapshot,
      List<TaskEntity> taskList,
      List<StatusEntity> statusList,
      List<TaskTypeEntity> taskTypeList,
      List<IndustryEntity> industryList,
      List<DocumentEntity> docList,
      List<MessageEntity> chatsList,
      List<UserEntity> usersList});
}

/// @nodoc
class __$$_TaskStateCopyWithImpl<$Res>
    extends _$TaskStateCopyWithImpl<$Res, _$_TaskState>
    implements _$$_TaskStateCopyWith<$Res> {
  __$$_TaskStateCopyWithImpl(
      _$_TaskState _value, $Res Function(_$_TaskState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? asyncSnapshot = freezed,
    Object? taskList = null,
    Object? statusList = null,
    Object? taskTypeList = null,
    Object? industryList = null,
    Object? docList = null,
    Object? chatsList = null,
    Object? usersList = null,
  }) {
    return _then(_$_TaskState(
      asyncSnapshot: freezed == asyncSnapshot
          ? _value.asyncSnapshot
          : asyncSnapshot // ignore: cast_nullable_to_non_nullable
              as AsyncSnapshot<dynamic>?,
      taskList: null == taskList
          ? _value._taskList
          : taskList // ignore: cast_nullable_to_non_nullable
              as List<TaskEntity>,
      statusList: null == statusList
          ? _value._statusList
          : statusList // ignore: cast_nullable_to_non_nullable
              as List<StatusEntity>,
      taskTypeList: null == taskTypeList
          ? _value._taskTypeList
          : taskTypeList // ignore: cast_nullable_to_non_nullable
              as List<TaskTypeEntity>,
      industryList: null == industryList
          ? _value._industryList
          : industryList // ignore: cast_nullable_to_non_nullable
              as List<IndustryEntity>,
      docList: null == docList
          ? _value._docList
          : docList // ignore: cast_nullable_to_non_nullable
              as List<DocumentEntity>,
      chatsList: null == chatsList
          ? _value._chatsList
          : chatsList // ignore: cast_nullable_to_non_nullable
              as List<MessageEntity>,
      usersList: null == usersList
          ? _value._usersList
          : usersList // ignore: cast_nullable_to_non_nullable
              as List<UserEntity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskState implements _TaskState {
  const _$_TaskState(
      {@JsonKey(ignore: true) this.asyncSnapshot,
      final List<TaskEntity> taskList = const [],
      final List<StatusEntity> statusList = const [],
      final List<TaskTypeEntity> taskTypeList = const [],
      final List<IndustryEntity> industryList = const [],
      final List<DocumentEntity> docList = const [],
      final List<MessageEntity> chatsList = const [],
      final List<UserEntity> usersList = const []})
      : _taskList = taskList,
        _statusList = statusList,
        _taskTypeList = taskTypeList,
        _industryList = industryList,
        _docList = docList,
        _chatsList = chatsList,
        _usersList = usersList;

  factory _$_TaskState.fromJson(Map<String, dynamic> json) =>
      _$$_TaskStateFromJson(json);

  @override
  @JsonKey(ignore: true)
  final AsyncSnapshot<dynamic>? asyncSnapshot;
  final List<TaskEntity> _taskList;
  @override
  @JsonKey()
  List<TaskEntity> get taskList {
    if (_taskList is EqualUnmodifiableListView) return _taskList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskList);
  }

  final List<StatusEntity> _statusList;
  @override
  @JsonKey()
  List<StatusEntity> get statusList {
    if (_statusList is EqualUnmodifiableListView) return _statusList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_statusList);
  }

  final List<TaskTypeEntity> _taskTypeList;
  @override
  @JsonKey()
  List<TaskTypeEntity> get taskTypeList {
    if (_taskTypeList is EqualUnmodifiableListView) return _taskTypeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskTypeList);
  }

  final List<IndustryEntity> _industryList;
  @override
  @JsonKey()
  List<IndustryEntity> get industryList {
    if (_industryList is EqualUnmodifiableListView) return _industryList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_industryList);
  }

  final List<DocumentEntity> _docList;
  @override
  @JsonKey()
  List<DocumentEntity> get docList {
    if (_docList is EqualUnmodifiableListView) return _docList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_docList);
  }

  final List<MessageEntity> _chatsList;
  @override
  @JsonKey()
  List<MessageEntity> get chatsList {
    if (_chatsList is EqualUnmodifiableListView) return _chatsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatsList);
  }

  final List<UserEntity> _usersList;
  @override
  @JsonKey()
  List<UserEntity> get usersList {
    if (_usersList is EqualUnmodifiableListView) return _usersList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_usersList);
  }

  @override
  String toString() {
    return 'TaskState(asyncSnapshot: $asyncSnapshot, taskList: $taskList, statusList: $statusList, taskTypeList: $taskTypeList, industryList: $industryList, docList: $docList, chatsList: $chatsList, usersList: $usersList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskState &&
            (identical(other.asyncSnapshot, asyncSnapshot) ||
                other.asyncSnapshot == asyncSnapshot) &&
            const DeepCollectionEquality().equals(other._taskList, _taskList) &&
            const DeepCollectionEquality()
                .equals(other._statusList, _statusList) &&
            const DeepCollectionEquality()
                .equals(other._taskTypeList, _taskTypeList) &&
            const DeepCollectionEquality()
                .equals(other._industryList, _industryList) &&
            const DeepCollectionEquality().equals(other._docList, _docList) &&
            const DeepCollectionEquality()
                .equals(other._chatsList, _chatsList) &&
            const DeepCollectionEquality()
                .equals(other._usersList, _usersList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      asyncSnapshot,
      const DeepCollectionEquality().hash(_taskList),
      const DeepCollectionEquality().hash(_statusList),
      const DeepCollectionEquality().hash(_taskTypeList),
      const DeepCollectionEquality().hash(_industryList),
      const DeepCollectionEquality().hash(_docList),
      const DeepCollectionEquality().hash(_chatsList),
      const DeepCollectionEquality().hash(_usersList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskStateCopyWith<_$_TaskState> get copyWith =>
      __$$_TaskStateCopyWithImpl<_$_TaskState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskStateToJson(
      this,
    );
  }
}

abstract class _TaskState implements TaskState {
  const factory _TaskState(
      {@JsonKey(ignore: true) final AsyncSnapshot<dynamic>? asyncSnapshot,
      final List<TaskEntity> taskList,
      final List<StatusEntity> statusList,
      final List<TaskTypeEntity> taskTypeList,
      final List<IndustryEntity> industryList,
      final List<DocumentEntity> docList,
      final List<MessageEntity> chatsList,
      final List<UserEntity> usersList}) = _$_TaskState;

  factory _TaskState.fromJson(Map<String, dynamic> json) =
      _$_TaskState.fromJson;

  @override
  @JsonKey(ignore: true)
  AsyncSnapshot<dynamic>? get asyncSnapshot;
  @override
  List<TaskEntity> get taskList;
  @override
  List<StatusEntity> get statusList;
  @override
  List<TaskTypeEntity> get taskTypeList;
  @override
  List<IndustryEntity> get industryList;
  @override
  List<DocumentEntity> get docList;
  @override
  List<MessageEntity> get chatsList;
  @override
  List<UserEntity> get usersList;
  @override
  @JsonKey(ignore: true)
  _$$_TaskStateCopyWith<_$_TaskState> get copyWith =>
      throw _privateConstructorUsedError;
}
