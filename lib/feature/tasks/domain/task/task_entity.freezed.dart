// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskEntity _$TaskEntityFromJson(Map<String, dynamic> json) {
  return _TaskEntity.fromJson(json);
}

/// @nodoc
mixin _$TaskEntity {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get startOfWork => throw _privateConstructorUsedError;
  DateTime? get endOfWork => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get contractorCompany => throw _privateConstructorUsedError;
  String? get responsibleMaster => throw _privateConstructorUsedError;
  String? get representative => throw _privateConstructorUsedError;
  String? get equipmentLevel => throw _privateConstructorUsedError;
  String? get staffLevel => throw _privateConstructorUsedError;
  String? get resultsOfTheWork => throw _privateConstructorUsedError;
  int? get idCategory => throw _privateConstructorUsedError;
  CategoryEntity? get category => throw _privateConstructorUsedError;
  UserEntity? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskEntityCopyWith<TaskEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskEntityCopyWith<$Res> {
  factory $TaskEntityCopyWith(
          TaskEntity value, $Res Function(TaskEntity) then) =
      _$TaskEntityCopyWithImpl<$Res, TaskEntity>;
  @useResult
  $Res call(
      {int id,
      String title,
      String? content,
      DateTime createdAt,
      DateTime? startOfWork,
      DateTime? endOfWork,
      String? imageUrl,
      String? contractorCompany,
      String? responsibleMaster,
      String? representative,
      String? equipmentLevel,
      String? staffLevel,
      String? resultsOfTheWork,
      int? idCategory,
      CategoryEntity? category,
      UserEntity? user});

  $CategoryEntityCopyWith<$Res>? get category;
  $UserEntityCopyWith<$Res>? get user;
}

/// @nodoc
class _$TaskEntityCopyWithImpl<$Res, $Val extends TaskEntity>
    implements $TaskEntityCopyWith<$Res> {
  _$TaskEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = freezed,
    Object? createdAt = null,
    Object? startOfWork = freezed,
    Object? endOfWork = freezed,
    Object? imageUrl = freezed,
    Object? contractorCompany = freezed,
    Object? responsibleMaster = freezed,
    Object? representative = freezed,
    Object? equipmentLevel = freezed,
    Object? staffLevel = freezed,
    Object? resultsOfTheWork = freezed,
    Object? idCategory = freezed,
    Object? category = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startOfWork: freezed == startOfWork
          ? _value.startOfWork
          : startOfWork // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endOfWork: freezed == endOfWork
          ? _value.endOfWork
          : endOfWork // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      contractorCompany: freezed == contractorCompany
          ? _value.contractorCompany
          : contractorCompany // ignore: cast_nullable_to_non_nullable
              as String?,
      responsibleMaster: freezed == responsibleMaster
          ? _value.responsibleMaster
          : responsibleMaster // ignore: cast_nullable_to_non_nullable
              as String?,
      representative: freezed == representative
          ? _value.representative
          : representative // ignore: cast_nullable_to_non_nullable
              as String?,
      equipmentLevel: freezed == equipmentLevel
          ? _value.equipmentLevel
          : equipmentLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      staffLevel: freezed == staffLevel
          ? _value.staffLevel
          : staffLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      resultsOfTheWork: freezed == resultsOfTheWork
          ? _value.resultsOfTheWork
          : resultsOfTheWork // ignore: cast_nullable_to_non_nullable
              as String?,
      idCategory: freezed == idCategory
          ? _value.idCategory
          : idCategory // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryEntity?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryEntityCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryEntityCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
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
}

/// @nodoc
abstract class _$$_TaskEntityCopyWith<$Res>
    implements $TaskEntityCopyWith<$Res> {
  factory _$$_TaskEntityCopyWith(
          _$_TaskEntity value, $Res Function(_$_TaskEntity) then) =
      __$$_TaskEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String? content,
      DateTime createdAt,
      DateTime? startOfWork,
      DateTime? endOfWork,
      String? imageUrl,
      String? contractorCompany,
      String? responsibleMaster,
      String? representative,
      String? equipmentLevel,
      String? staffLevel,
      String? resultsOfTheWork,
      int? idCategory,
      CategoryEntity? category,
      UserEntity? user});

  @override
  $CategoryEntityCopyWith<$Res>? get category;
  @override
  $UserEntityCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_TaskEntityCopyWithImpl<$Res>
    extends _$TaskEntityCopyWithImpl<$Res, _$_TaskEntity>
    implements _$$_TaskEntityCopyWith<$Res> {
  __$$_TaskEntityCopyWithImpl(
      _$_TaskEntity _value, $Res Function(_$_TaskEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = freezed,
    Object? createdAt = null,
    Object? startOfWork = freezed,
    Object? endOfWork = freezed,
    Object? imageUrl = freezed,
    Object? contractorCompany = freezed,
    Object? responsibleMaster = freezed,
    Object? representative = freezed,
    Object? equipmentLevel = freezed,
    Object? staffLevel = freezed,
    Object? resultsOfTheWork = freezed,
    Object? idCategory = freezed,
    Object? category = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_TaskEntity(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startOfWork: freezed == startOfWork
          ? _value.startOfWork
          : startOfWork // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endOfWork: freezed == endOfWork
          ? _value.endOfWork
          : endOfWork // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      contractorCompany: freezed == contractorCompany
          ? _value.contractorCompany
          : contractorCompany // ignore: cast_nullable_to_non_nullable
              as String?,
      responsibleMaster: freezed == responsibleMaster
          ? _value.responsibleMaster
          : responsibleMaster // ignore: cast_nullable_to_non_nullable
              as String?,
      representative: freezed == representative
          ? _value.representative
          : representative // ignore: cast_nullable_to_non_nullable
              as String?,
      equipmentLevel: freezed == equipmentLevel
          ? _value.equipmentLevel
          : equipmentLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      staffLevel: freezed == staffLevel
          ? _value.staffLevel
          : staffLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      resultsOfTheWork: freezed == resultsOfTheWork
          ? _value.resultsOfTheWork
          : resultsOfTheWork // ignore: cast_nullable_to_non_nullable
              as String?,
      idCategory: freezed == idCategory
          ? _value.idCategory
          : idCategory // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryEntity?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskEntity extends _TaskEntity {
  const _$_TaskEntity(
      {required this.id,
      required this.title,
      this.content,
      required this.createdAt,
      this.startOfWork,
      this.endOfWork,
      this.imageUrl,
      this.contractorCompany,
      this.responsibleMaster,
      this.representative,
      this.equipmentLevel,
      this.staffLevel,
      this.resultsOfTheWork,
      this.idCategory,
      this.category,
      this.user})
      : super._();

  factory _$_TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$$_TaskEntityFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? content;
  @override
  final DateTime createdAt;
  @override
  final DateTime? startOfWork;
  @override
  final DateTime? endOfWork;
  @override
  final String? imageUrl;
  @override
  final String? contractorCompany;
  @override
  final String? responsibleMaster;
  @override
  final String? representative;
  @override
  final String? equipmentLevel;
  @override
  final String? staffLevel;
  @override
  final String? resultsOfTheWork;
  @override
  final int? idCategory;
  @override
  final CategoryEntity? category;
  @override
  final UserEntity? user;

  @override
  String toString() {
    return 'TaskEntity(id: $id, title: $title, content: $content, createdAt: $createdAt, startOfWork: $startOfWork, endOfWork: $endOfWork, imageUrl: $imageUrl, contractorCompany: $contractorCompany, responsibleMaster: $responsibleMaster, representative: $representative, equipmentLevel: $equipmentLevel, staffLevel: $staffLevel, resultsOfTheWork: $resultsOfTheWork, idCategory: $idCategory, category: $category, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.startOfWork, startOfWork) ||
                other.startOfWork == startOfWork) &&
            (identical(other.endOfWork, endOfWork) ||
                other.endOfWork == endOfWork) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.contractorCompany, contractorCompany) ||
                other.contractorCompany == contractorCompany) &&
            (identical(other.responsibleMaster, responsibleMaster) ||
                other.responsibleMaster == responsibleMaster) &&
            (identical(other.representative, representative) ||
                other.representative == representative) &&
            (identical(other.equipmentLevel, equipmentLevel) ||
                other.equipmentLevel == equipmentLevel) &&
            (identical(other.staffLevel, staffLevel) ||
                other.staffLevel == staffLevel) &&
            (identical(other.resultsOfTheWork, resultsOfTheWork) ||
                other.resultsOfTheWork == resultsOfTheWork) &&
            (identical(other.idCategory, idCategory) ||
                other.idCategory == idCategory) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      content,
      createdAt,
      startOfWork,
      endOfWork,
      imageUrl,
      contractorCompany,
      responsibleMaster,
      representative,
      equipmentLevel,
      staffLevel,
      resultsOfTheWork,
      idCategory,
      category,
      user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskEntityCopyWith<_$_TaskEntity> get copyWith =>
      __$$_TaskEntityCopyWithImpl<_$_TaskEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskEntityToJson(
      this,
    );
  }
}

abstract class _TaskEntity extends TaskEntity {
  const factory _TaskEntity(
      {required final int id,
      required final String title,
      final String? content,
      required final DateTime createdAt,
      final DateTime? startOfWork,
      final DateTime? endOfWork,
      final String? imageUrl,
      final String? contractorCompany,
      final String? responsibleMaster,
      final String? representative,
      final String? equipmentLevel,
      final String? staffLevel,
      final String? resultsOfTheWork,
      final int? idCategory,
      final CategoryEntity? category,
      final UserEntity? user}) = _$_TaskEntity;
  const _TaskEntity._() : super._();

  factory _TaskEntity.fromJson(Map<String, dynamic> json) =
      _$_TaskEntity.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String? get content;
  @override
  DateTime get createdAt;
  @override
  DateTime? get startOfWork;
  @override
  DateTime? get endOfWork;
  @override
  String? get imageUrl;
  @override
  String? get contractorCompany;
  @override
  String? get responsibleMaster;
  @override
  String? get representative;
  @override
  String? get equipmentLevel;
  @override
  String? get staffLevel;
  @override
  String? get resultsOfTheWork;
  @override
  int? get idCategory;
  @override
  CategoryEntity? get category;
  @override
  UserEntity? get user;
  @override
  @JsonKey(ignore: true)
  _$$_TaskEntityCopyWith<_$_TaskEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
