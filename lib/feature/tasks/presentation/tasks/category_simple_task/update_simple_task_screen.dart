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

class UpdateSimpleTaskScreen extends StatelessWidget {
  const UpdateSimpleTaskScreen(
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
  DateTime endWorkDateTime = DateTime.now();
  bool showDate = false;
  bool showTime = false;
  bool showEndWorkDateTime = false;

  TextEditingController? titleController;
  TextEditingController? masterController;
  TextEditingController? commentsController;
  final GlobalKey<FormState> formKey = GlobalKey();

  final ImgStorage storage = ImgStorage();
  Future<String>? imgDownload;

  File? imageFile;
  String? fileName;

  int? selectedItemId;

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
    if (widget.taskEntity.status != null) {
      selectedItemId = widget.taskEntity.status?.id;
    }
    titleController = TextEditingController(text: widget.taskEntity.title);
    masterController =
        TextEditingController(text: widget.taskEntity.responsibleMaster);
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

  String getEndWorkDateTime() =>
      DateFormat('yyyy-MM-dd – kk:mm').format(endWorkDateTime);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Редактировать задачу"),
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
                "startOfWork": selectedDate.toString(),
                "endOfWork": endWorkDateTime.toString(),
                "imageUrl": fileName,
                "contractorCompany": null,
                "responsibleMaster": masterController?.text,
                "representative": null,
                "equipmentLevel": null,
                "staffLevel": null,
                "resultsOfTheWork": null,
                "expenses": null,
                "idCategory": 3,
                "idStatus": selectedItemId,
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
                          Text('Описание',
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
                const SizedBox(height: 10),
                //run to
                Card(
                  color: Colors.grey.shade200,
                  child: SizedBox(
                    width: 342,
                    height: 125,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Выполнить до',
                              style: theme.textTheme.headlineSmall),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              showEndWorkDateTime
                                  ? const Icon(Icons.date_range_outlined,
                                      color: Color(0xFF0d74ba))
                                  : Flexible(
                                      child: Text(widget.taskEntity.endOfWork
                                          .toString()
                                          .split(".")[0]),
                                    ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Center(
                                child: Text(
                                  'Изменить дату и время',
                                  style: theme.textTheme.labelMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //responsible master
                Row(
                  children: [
                    const SizedBox(width: 25),
                    Text("Ответственное лицо",
                        style: theme.textTheme.headlineSmall)
                  ],
                ),
                const SizedBox(height: 8),
                AppTextField(
                    hintText: 'Ответственное лицо',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF0d74ba)),
                    controller: masterController!,
                    validator: (master) =>
                        master != null ? 'Укажите ответственное лицо' : null),
                const SizedBox(height: 10),
                //images
                Card(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  color: Colors.grey.shade200,
                  child: widget.taskEntity.imageUrl == null && imageFile == null
                      ? SizedBox(
                          width: 342,
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
                //status
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
                          Text('Статус',
                              style: theme.textTheme.headlineSmall),
                          BlocConsumer<TaskCubit, TaskState>(
                              builder: (context, state) {
                                if (state.statusList.isNotEmpty) {
                                  return DropdownButton<int>(
                                      isExpanded: true,
                                      value: selectedItemId,
                                      items: state.statusList.map((e) {
                                        return DropdownMenuItem(
                                          value: e.id,
                                          child: Row(children: <Widget>[
                                            Text(e.name.toString())
                                          ]),
                                        );
                                      }).toList(),
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          selectedItemId = newValue;
                                        });
                                      });
                                }
                                return const SizedBox.shrink();
                              },
                              listener: (context, state) {}),
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
