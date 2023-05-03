import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/app/presentation/components/app_text_field.dart';
import 'package:planner_etp/feature/tasks/domain/image_storage_service.dart';
import 'package:planner_etp/feature/tasks/domain/state/detail/detail_task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/domain/task_repository.dart';

class UpdateObjectLogScreen extends StatelessWidget {
  const UpdateObjectLogScreen(
      {Key? key, required this.id, required this.taskEntity})
      : super(key: key);

  final String id;
  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailTaskCubit(locator.get<TaskRepository>(), id),
      child: _UpdateTaskView(taskEntity: taskEntity),
    );
  }
}

class _UpdateTaskView extends StatefulWidget {
  final TaskEntity taskEntity;

  const _UpdateTaskView({required this.taskEntity});

  @override
  State<StatefulWidget> createState() => _UpdateTaskViewState();
}

class _UpdateTaskViewState extends State<_UpdateTaskView> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime startWorkDateTime = DateTime.now();
  DateTime endWorkDateTime = DateTime.now();
  bool showDate = false;
  bool showTime = false;
  bool showStartWorkDateTime = false;
  bool showEndWorkDateTime = false;

  TextEditingController? titleController;
  TextEditingController? companyController;
  TextEditingController? masterController;
  TextEditingController? representativeController;
  TextEditingController? equipmentLevelController;
  TextEditingController? staffLevelController;
  TextEditingController? resultsOfTheWorkController;
  TextEditingController? commentsController;
  final GlobalKey<FormState> formKey = GlobalKey();

  final FileImgStorage storage = FileImgStorage();
  Future<String>? imgDownload;

  File? imageFile;
  String? fileName;

  void _getImgFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 320,
      maxHeight: 320,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    if (widget.taskEntity.imageUrl != null) {
      imgDownload = storage.downloadImage(widget.taskEntity.imageUrl ?? "");
    }
    titleController = TextEditingController(text: widget.taskEntity.title);
    companyController =
        TextEditingController(text: widget.taskEntity.contractorCompany);
    masterController =
        TextEditingController(text: widget.taskEntity.responsibleMaster);
    representativeController =
        TextEditingController(text: widget.taskEntity.representative);
    equipmentLevelController =
        TextEditingController(text: widget.taskEntity.equipmentLevel);
    staffLevelController = TextEditingController(text: widget.taskEntity.staffLevel);
    resultsOfTheWorkController =
        TextEditingController(text: widget.taskEntity.resultsOfTheWork);
    commentsController = TextEditingController(text: widget.taskEntity.content);
    super.initState();
  }

  // Select for Date
  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))))) {
      return true;
    }
    return false;
  }

  // Select for Time
  Future<TimeOfDay> _selectTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

  Future _selectStartWorkDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    final time = await _selectTime();

    setState(() {
      startWorkDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future _selectEndWorkDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    final time = await _selectTime();

    setState(() {
      endWorkDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  String getStartWorkDateTime() =>
      DateFormat('yyyy-MM-dd kk:mm').format(startWorkDateTime);

  String getEndWorkDateTime() =>
      DateFormat('yyyy-MM-dd – kk:mm').format(endWorkDateTime);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Редактировать журнал"),
        actions: [
          IconButton(
            onPressed: () {
              if (imageFile != null) {
                fileName = storage.getRandomString(7);
                storage.uploadImage(imageFile!.path, fileName!);
              }
              context.read<DetailTaskCubit>().updateTask({
                "title": titleController?.text,
                "content": commentsController?.text,
                "startOfWork": startWorkDateTime.toString(),
                "endOfWork": endWorkDateTime.toString(),
                "imageUrl": fileName,
                "contractorCompany": companyController?.text,
                "responsibleMaster": masterController?.text,
                "representative": representativeController?.text,
                "equipmentLevel": equipmentLevelController?.text,
                "staffLevel": staffLevelController?.text,
                "resultsOfTheWork": resultsOfTheWorkController?.text,
                "expenses": null,
                "idCategory": 1,
                "idStatus": null,
                "idIndustry": null,
                "idTaskType": null
              }).then((_) {
                context.read<DetailTaskCubit>().fetchTask();
                context.read<TaskCubit>().fetchTasks();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              children: [
                //title
                Row(
                  children: [
                    const SizedBox(width: 25),
                    Text("Название", style: theme.textTheme.headlineSmall)
                  ],
                ),
                const SizedBox(height: 8),
                AppTextField(
                    hintText: 'Название',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF0d74ba)),
                    controller: titleController!,
                    validator: (title) =>
                        title != null ? 'Введите название' : null),
                const SizedBox(height: 10),
                //start and end datetime
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //start of work
                    Card(
                      color: Colors.grey.shade200,
                      child: SizedBox(
                        width: 166,
                        height: 135,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Начало работ',
                                  style: theme.textTheme.headlineSmall),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  showStartWorkDateTime
                                      ? const Icon(Icons.date_range_outlined,
                                          color: Color(0xFF0d74ba))
                                      : Flexible(
                                          child: Text(
                                              widget.taskEntity.startOfWork
                                                  .toString()
                                                  .split(".")[0],
                                              textAlign: TextAlign.center)),
                                  const SizedBox(width: 5),
                                  showStartWorkDateTime
                                      ? Flexible(
                                          child: Text(
                                          getStartWorkDateTime(),
                                          style: theme.textTheme.bodyMedium,
                                        ))
                                      : const SizedBox(),
                                ],
                              ),
                              MaterialButton(
                                onPressed: () {
                                  _selectStartWorkDateTime(context);
                                  showStartWorkDateTime = true;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    'Изменить\nдату и время',
                                    style: theme.textTheme.labelMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //end of work
                    Card(
                      color: Colors.grey.shade200,
                      child: SizedBox(
                        width: 166,
                        height: 135,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Окончание работ',
                                  style: theme.textTheme.headlineSmall),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  showEndWorkDateTime
                                      ? const Icon(Icons.date_range_outlined,
                                          color: Color(0xFF0d74ba))
                                      : Flexible(
                                          child: Text(
                                              widget.taskEntity.endOfWork
                                                  .toString()
                                                  .split(".")[0],
                                              textAlign: TextAlign.center)),
                                  const SizedBox(width: 5),
                                  showEndWorkDateTime
                                      ? Flexible(
                                          child: Text(
                                          getEndWorkDateTime(),
                                          style: theme.textTheme.bodyMedium,
                                        ))
                                      : const SizedBox(),
                                ],
                              ),
                              MaterialButton(
                                onPressed: () {
                                  _selectEndWorkDateTime(context);
                                  showEndWorkDateTime = true;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    'Изменить\nдату и время',
                                    style: theme.textTheme.labelMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                //contractor company
                Row(
                  children: [
                    const SizedBox(width: 25),
                    Text("Компания исполнитель",
                        style: theme.textTheme.headlineSmall)
                  ],
                ),
                const SizedBox(height: 8),
                AppTextField(
                    hintText: 'Компания исполнитель',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF0d74ba)),
                    controller: companyController!,
                    validator: (company) => company != null
                        ? 'Укажите компанию исполнителя'
                        : null),
                const SizedBox(height: 10),
                //responsible master
                Row(
                  children: [
                    const SizedBox(width: 25),
                    Text("Ответственный мастер",
                        style: theme.textTheme.headlineSmall)
                  ],
                ),
                const SizedBox(height: 8),
                AppTextField(
                    hintText: 'Ответственный мастер',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF0d74ba)),
                    controller: masterController!,
                    validator: (master) => master != null
                        ? 'Укажите ответственного мастера'
                        : null),
                const SizedBox(height: 10),
                //representative
                Row(
                  children: [
                    const SizedBox(width: 25),
                    Text("Представитель", style: theme.textTheme.headlineSmall)
                  ],
                ),
                const SizedBox(height: 8),
                AppTextField(
                    hintText: 'Представитель',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF0d74ba)),
                    controller: representativeController!,
                    validator: (representative) => representative != null
                        ? 'Укажите представителя'
                        : null),
                const SizedBox(height: 10),
                //images
                Card(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  color: Colors.grey.shade200,
                  child: widget.taskEntity.imageUrl == null && imageFile == null
                      ? SizedBox(
                          width: 365,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Фото',
                                    style: theme.textTheme.headlineSmall),
                                const SizedBox(height: 10),
                                MaterialButton(
                                  onPressed: () {
                                    _getImgFromGallery();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 55.0),
                                    child: Text(
                                      'Добавить медиафайл',
                                      style: theme.textTheme.labelMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : GFCard(
                          boxFit: BoxFit.cover,
                          color: Colors.grey.shade200,
                          margin: EdgeInsets.zero,
                          title: GFListTile(
                            title: Text('Фото',
                                style: theme.textTheme.headlineSmall),
                          ),
                          content: SizedBox(
                            child: imageFile == null
                                ? FutureBuilder(
                                    future: imgDownload,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.hasData) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            imageFile == null
                                                ? Image.network(
                                                    snapshot.data ?? "",
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.file(
                                                    imageFile!,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ],
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    },
                                  )
                                : SizedBox(
                                    width: 342,
                                    height: 220,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.file(
                                            imageFile!,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                          buttonBar: GFButtonBar(
                            children: <Widget>[
                              GFButton(
                                onPressed: () {
                                  _getImgFromGallery();
                                },
                                text: 'Выбрать другой медиафайл',
                              ),
                            ],
                          ),
                        ),
                ),
                const SizedBox(height: 10),
                //equipment level
                Row(
                  children: [
                    const SizedBox(width: 25),
                    Text("Уровень оснащения",
                        style: theme.textTheme.headlineSmall)
                  ],
                ),
                const SizedBox(height: 8),
                AppTextField(
                    hintText: 'Уровень оснащения',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF0d74ba)),
                    controller: equipmentLevelController!,
                    validator: (equipmentLevel) => equipmentLevel != null
                        ? 'Укажите уровень оснащения'
                        : null),
                const SizedBox(height: 10),
                //staff level
                Row(
                  children: [
                    const SizedBox(width: 25),
                    Text("Уровень персонала",
                        style: theme.textTheme.headlineSmall)
                  ],
                ),
                const SizedBox(height: 8),
                AppTextField(
                    hintText: 'Уровень персонала',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF0d74ba)),
                    controller: staffLevelController!,
                    validator: (staffLevel) => staffLevel != null
                        ? 'Укажите уровень персонала'
                        : null),
                const SizedBox(height: 10),
                //resultsOfTheWork
                Card(
                  color: Colors.grey.shade200,
                  child: SizedBox(
                    width: 342,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Результаты работы',
                              style: theme.textTheme.headlineSmall),
                          Expanded(
                            child: TextFormField(
                              controller: resultsOfTheWorkController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //comments
                Card(
                  color: Colors.grey.shade200,
                  child: SizedBox(
                    width: 342,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Комментарии',
                              style: theme.textTheme.headlineSmall),
                          Expanded(
                            child: TextFormField(
                              controller: commentsController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
