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
  String? get fileUrl => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  String? get contractorCompany => throw _privateConstructorUsedError;
  String? get responsibleMaster => throw _privateConstructorUsedError;
  String? get representative => throw _privateConstructorUsedError;
  String? get equipmentLevel => throw _privateConstructorUsedError;
  String? get staffLevel => throw _privateConstructorUsedError;
  String? get resultsOfTheWork => throw _privateConstructorUsedError;
  String? get expenses => throw _privateConstructorUsedError;
  int? get idCategory => throw _privateConstructorUsedError;
  int? get idStatus => throw _privateConstructorUsedError;
  int? get idIndustry => throw _privateConstructorUsedError;
  int? get idTaskType => throw _privateConstructorUsedError;
  CategoryEntity? get category => throw _privateConstructorUsedError;
  StatusEntity? get status => throw _privateConstructorUsedError;
  IndustryEntity? get industry => throw _privateConstructorUsedError;
  TaskTypeEntity? get taskType => throw _privateConstructorUsedError;
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
      String? fileUrl,
      String? fileName,
      String? contractorCompany,
      String? responsibleMaster,
      String? representative,
      String? equipmentLevel,
      String? staffLevel,
      String? resultsOfTheWork,
      String? expenses,
      int? idCategory,
      int? idStatus,
      int? idIndustry,
      int? idTaskType,
      CategoryEntity? category,
      StatusEntity? status,
      IndustryEntity? industry,
      TaskTypeEntity? taskType,
      UserEntity? user});

  $CategoryEntityCopyWith<$Res>? get category;
  $StatusEntityCopyWith<$Res>? get status;
  $IndustryEntityCopyWith<$Res>? get industry;
  $TaskTypeEntityCopyWith<$Res>? get taskType;
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
    Object? fileUrl = freezed,
    Object? fileName = freezed,
    Object? contractorCompany = freezed,
    Object? responsibleMaster = freezed,
    Object? representative = freezed,
    Object? equipmentLevel = freezed,
    Object? staffLevel = freezed,
    Object? resultsOfTheWork = freezed,
    Object? expenses = freezed,
    Object? idCategory = freezed,
    Object? idStatus = freezed,
    Object? idIndustry = freezed,
    Object? idTaskType = freezed,
    Object? category = freezed,
    Object? status = freezed,
    Object? industry = freezed,
    Object? taskType = freezed,
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
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
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
      expenses: freezed == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as String?,
      idCategory: freezed == idCategory
          ? _value.idCategory
          : idCategory // ignore: cast_nullable_to_non_nullable
              as int?,
      idStatus: freezed == idStatus
          ? _value.idStatus
          : idStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      idIndustry: freezed == idIndustry
          ? _value.idIndustry
          : idIndustry // ignore: cast_nullable_to_non_nullable
              as int?,
      idTaskType: freezed == idTaskType
          ? _value.idTaskType
          : idTaskType // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryEntity?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusEntity?,
      industry: freezed == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as IndustryEntity?,
      taskType: freezed == taskType
          ? _value.taskType
          : taskType // ignore: cast_nullable_to_non_nullable
              as TaskTypeEntity?,
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
  $StatusEntityCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $StatusEntityCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IndustryEntityCopyWith<$Res>? get industry {
    if (_value.industry == null) {
      return null;
    }

    return $IndustryEntityCopyWith<$Res>(_value.industry!, (value) {
      return _then(_value.copyWith(industry: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskTypeEntityCopyWith<$Res>? get taskType {
    if (_value.taskType == null) {
      return null;
    }

    return $TaskTypeEntityCopyWith<$Res>(_value.taskType!, (value) {
      return _then(_value.copyWith(taskType: value) as $Val);
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
      String? fileUrl,
      String? fileName,
      String? contractorCompany,
      String? responsibleMaster,
      String? representative,
      String? equipmentLevel,
      String? staffLevel,
      String? resultsOfTheWork,
      String? expenses,
      int? idCategory,
      int? idStatus,
      int? idIndustry,
      int? idTaskType,
      CategoryEntity? category,
      StatusEntity? status,
      IndustryEntity? industry,
      TaskTypeEntity? taskType,
      UserEntity? user});

  @override
  $CategoryEntityCopyWith<$Res>? get category;
  @override
  $StatusEntityCopyWith<$Res>? get status;
  @override
  $IndustryEntityCopyWith<$Res>? get industry;
  @override
  $TaskTypeEntityCopyWith<$Res>? get taskType;
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
    Object? fileUrl = freezed,
    Object? fileName = freezed,
    Object? contractorCompany = freezed,
    Object? responsibleMaster = freezed,
    Object? representative = freezed,
    Object? equipmentLevel = freezed,
    Object? staffLevel = freezed,
    Object? resultsOfTheWork = freezed,
    Object? expenses = freezed,
    Object? idCategory = freezed,
    Object? idStatus = freezed,
    Object? idIndustry = freezed,
    Object? idTaskType = freezed,
    Object? category = freezed,
    Object? status = freezed,
    Object? industry = freezed,
    Object? taskType = freezed,
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
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
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
      expenses: freezed == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as String?,
      idCategory: freezed == idCategory
          ? _value.idCategory
          : idCategory // ignore: cast_nullable_to_non_nullable
              as int?,
      idStatus: freezed == idStatus
          ? _value.idStatus
          : idStatus // ignore: cast_nullable_to_non_nullable
              as int?,
      idIndustry: freezed == idIndustry
          ? _value.idIndustry
          : idIndustry // ignore: cast_nullable_to_non_nullable
              as int?,
      idTaskType: freezed == idTaskType
          ? _value.idTaskType
          : idTaskType // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryEntity?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusEntity?,
      industry: freezed == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as IndustryEntity?,
      taskType: freezed == taskType
          ? _value.taskType
          : taskType // ignore: cast_nullable_to_non_nullable
              as TaskTypeEntity?,
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
      this.fileUrl,
      this.fileName,
      this.contractorCompany,
      this.responsibleMaster,
      this.representative,
      this.equipmentLevel,
      this.staffLevel,
      this.resultsOfTheWork,
      this.expenses,
      this.idCategory,
      this.idStatus,
      this.idIndustry,
      this.idTaskType,
      this.category,
      this.status,
      this.industry,
      this.taskType,
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
  final String? fileUrl;
  @override
  final String? fileName;
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
  final String? expenses;
  @override
  final int? idCategory;
  @override
  final int? idStatus;
  @override
  final int? idIndustry;
  @override
  final int? idTaskType;
  @override
  final CategoryEntity? category;
  @override
  final StatusEntity? status;
  @override
  final IndustryEntity? industry;
  @override
  final TaskTypeEntity? taskType;
  @override
  final UserEntity? user;

  @override
  String toString() {
    return 'TaskEntity(id: $id, title: $title, content: $content, createdAt: $createdAt, startOfWork: $startOfWork, endOfWork: $endOfWork, imageUrl: $imageUrl, fileUrl: $fileUrl, fileName: $fileName, contractorCompany: $contractorCompany, responsibleMaster: $responsibleMaster, representative: $representative, equipmentLevel: $equipmentLevel, staffLevel: $staffLevel, resultsOfTheWork: $resultsOfTheWork, expenses: $expenses, idCategory: $idCategory, idStatus: $idStatus, idIndustry: $idIndustry, idTaskType: $idTaskType, category: $category, status: $status, industry: $industry, taskType: $taskType, user: $user)';
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
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
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
            (identical(other.expenses, expenses) ||
                other.expenses == expenses) &&
            (identical(other.idCategory, idCategory) ||
                other.idCategory == idCategory) &&
            (identical(other.idStatus, idStatus) ||
                other.idStatus == idStatus) &&
            (identical(other.idIndustry, idIndustry) ||
                other.idIndustry == idIndustry) &&
            (identical(other.idTaskType, idTaskType) ||
                other.idTaskType == idTaskType) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.industry, industry) ||
                other.industry == industry) &&
            (identical(other.taskType, taskType) ||
                other.taskType == taskType) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        content,
        createdAt,
        startOfWork,
        endOfWork,
        imageUrl,
        fileUrl,
        fileName,
        contractorCompany,
        responsibleMaster,
        representative,
        equipmentLevel,
        staffLevel,
        resultsOfTheWork,
        expenses,
        idCategory,
        idStatus,
        idIndustry,
        idTaskType,
        category,
        status,
        industry,
        taskType,
        user
      ]);

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
      final String? fileUrl,
      final String? fileName,
      final String? contractorCompany,
      final String? responsibleMaster,
      final String? representative,
      final String? equipmentLevel,
      final String? staffLevel,
      final String? resultsOfTheWork,
      final String? expenses,
      final int? idCategory,
      final int? idStatus,
      final int? idIndustry,
      final int? idTaskType,
      final CategoryEntity? category,
      final StatusEntity? status,
      final IndustryEntity? industry,
      final TaskTypeEntity? taskType,
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
  String? get fileUrl;
  @override
  String? get fileName;
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
  String? get expenses;
  @override
  int? get idCategory;
  @override
  int? get idStatus;
  @override
  int? get idIndustry;
  @override
  int? get idTaskType;
  @override
  CategoryEntity? get category;
  @override
  StatusEntity? get status;
  @override
  IndustryEntity? get industry;
  @override
  TaskTypeEntity? get taskType;
  @override
  UserEntity? get user;
  @override
  @JsonKey(ignore: true)
  _$$_TaskEntityCopyWith<_$_TaskEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
