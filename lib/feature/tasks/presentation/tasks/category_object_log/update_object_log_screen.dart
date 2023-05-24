import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/app/presentation/components/app_text_field.dart';
import 'package:planner_etp/feature/tasks/domain/file_pdf_service.dart';
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
  TextEditingController? fileNameController;
  final GlobalKey<FormState> formKey = GlobalKey();

  final FileImgStorage storage = FileImgStorage();
  Future<String>? imgDownload;
  Future<String>? fileMetadataPath;
  Future<String>? fileDownload;

  File? imageFile;
  String? fileName;
  File? pdfFile;
  String? pathPdf;
  SettableMetadata? settableMetadata;

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

  void _getPdfFile() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        // type: FileType.custom,
        // allowedExtensions: ['pdf'],
        );
    if (pickedFile != null) {
      setState(() {
        pathPdf = pickedFile.files.first.path;
        pdfFile = File(pickedFile.files.first.path!);
        settableMetadata = SettableMetadata(contentType: pathPdf);
        fileNameController!.text = pickedFile.files.first.name;
      });
    }
  }

  @override
  void initState() {
    if (widget.taskEntity.imageUrl != null) {
      imgDownload = storage.downloadImage(widget.taskEntity.imageUrl ?? "");
    }
    if (widget.taskEntity.fileUrl != null) {
      fileNameController =
          TextEditingController(text: widget.taskEntity.fileUrl);
      fileDownload = storage.downloadPdfFile(widget.taskEntity.fileUrl ?? "");
      fileMetadataPath =
          storage.downloadPdfFilePath(widget.taskEntity.fileUrl ?? "");
    }
    fileNameController = TextEditingController(text: widget.taskEntity.fileUrl);
    titleController = TextEditingController(text: widget.taskEntity.title);
    companyController =
        TextEditingController(text: widget.taskEntity.contractorCompany);
    masterController =
        TextEditingController(text: widget.taskEntity.responsibleMaster);
    representativeController =
        TextEditingController(text: widget.taskEntity.representative);
    equipmentLevelController =
        TextEditingController(text: widget.taskEntity.equipmentLevel);
    staffLevelController =
        TextEditingController(text: widget.taskEntity.staffLevel);
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
              if (fileNameController!.text.isNotEmpty) {
                storage.uploadPdfFile(
                    fileNameController!.text, pdfFile!, settableMetadata!);
              }
              context.read<DetailTaskCubit>().updateTask({
                "title": titleController?.text,
                "content": commentsController?.text,
                "startOfWork": startWorkDateTime.toString(),
                "endOfWork": endWorkDateTime.toString(),
                "imageUrl": fileName,
                "fileUrl": fileNameController!.text,
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
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.rate_review_outlined,
                      color: Color(0xFF0d74ba)),
                  controller: titleController!,
                  validator: (title) =>
                      title != null ? 'Введите название' : null,
                  minLines: 1,
                ),
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
                                              "${DateFormat.yMMMd("ru").format(widget.taskEntity.startOfWork!)},"
                                              "${DateFormat.Hm("ru").format(widget.taskEntity.startOfWork!)}",
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
                                              "${DateFormat.yMMMd("ru").format(widget.taskEntity.endOfWork!)},"
                                              "${DateFormat.Hm("ru").format(widget.taskEntity.endOfWork!)}",
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
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.rate_review_outlined,
                      color: Color(0xFF0d74ba)),
                  controller: companyController!,
                  validator: (company) =>
                      company != null ? 'Укажите компанию исполнителя' : null,
                  minLines: 1,
                ),
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
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.rate_review_outlined,
                      color: Color(0xFF0d74ba)),
                  controller: masterController!,
                  validator: (master) =>
                      master != null ? 'Укажите ответственного мастера' : null,
                  minLines: 1,
                ),
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
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.rate_review_outlined,
                      color: Color(0xFF0d74ba)),
                  controller: representativeController!,
                  validator: (representative) =>
                      representative != null ? 'Укажите представителя' : null,
                  minLines: 1,
                ),
                const SizedBox(height: 10),
                //images
                Card(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  color: Colors.grey.shade200,
                  child: widget.taskEntity.imageUrl == null ||
                          widget.taskEntity.imageUrl == "" && imageFile == null
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
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Фото',
                                                style: theme
                                                    .textTheme.headlineSmall),
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
                                          Text('Фото',
                                              style: theme
                                                  .textTheme.headlineSmall),
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
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.rate_review_outlined,
                      color: Color(0xFF0d74ba)),
                  controller: equipmentLevelController!,
                  validator: (equipmentLevel) => equipmentLevel != null
                      ? 'Укажите уровень оснащения'
                      : null,
                  minLines: 1,
                ),
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
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.rate_review_outlined,
                      color: Color(0xFF0d74ba)),
                  controller: staffLevelController!,
                  validator: (staffLevel) =>
                      staffLevel != null ? 'Укажите уровень персонала' : null,
                  minLines: 1,
                ),
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
                              maxLines: 5,
                              minLines: 1,
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
                              maxLines: 5,
                              minLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //documents
                Card(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  color: Colors.grey.shade200,
                  child: fileNameController!.text.isEmpty
                      ? SizedBox(
                          width: 342,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Документы',
                                    style: theme.textTheme.headlineSmall),
                                MaterialButton(
                                  onPressed: () {
                                    _getPdfFile();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 55.0),
                                    child: Text(
                                      'Добавить документ',
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
                          content: FutureBuilder(
                            future: fileMetadataPath,
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                final String path = snapshot.data!;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Документ',
                                        style: theme.textTheme.headlineSmall),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(fileNameController!.text),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                if (fileDownload != null) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PDFScreen(
                                                                path: path)),
                                                  );
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  foregroundColor: Colors.grey,
                                                  elevation: 0),
                                              child: const Icon(
                                                Icons.remove_red_eye,
                                                size: 25.0,
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  fileNameController?.clear();
                                                  fileDownload == null;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  foregroundColor: Colors.red,
                                                  elevation: 0),
                                              child: const Icon(
                                                Icons.clear,
                                                size: 25.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                return SizedBox(
                                  width: 342,
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Документ',
                                          style: theme.textTheme.headlineSmall),
                                      const SizedBox(height: 10),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(fileNameController!.text),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      if (pathPdf!.isNotEmpty) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PDFScreen(
                                                                      path:
                                                                          pathPdf)),
                                                        );
                                                      }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            foregroundColor:
                                                                Colors.grey,
                                                            elevation: 0),
                                                    child: const Icon(
                                                      Icons.remove_red_eye,
                                                      size: 25.0,
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        fileNameController
                                                            ?.clear();
                                                        fileDownload == null;
                                                      });
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            foregroundColor:
                                                                Colors.red,
                                                            elevation: 0),
                                                    child: const Icon(
                                                      Icons.clear,
                                                      size: 25.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
