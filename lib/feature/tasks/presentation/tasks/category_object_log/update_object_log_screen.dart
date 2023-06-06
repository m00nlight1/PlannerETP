import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/app/presentation/components/app_snack_bar.dart';
import 'package:planner_etp/app/presentation/components/app_text_field.dart';
import 'package:planner_etp/feature/tasks/domain/datetime_service.dart';
import 'package:planner_etp/feature/tasks/presentation/pdf_viewer_screen.dart';
import 'package:planner_etp/feature/tasks/domain/firebase_storage_service.dart';
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
  TextEditingController? imageNameController;
  final GlobalKey<FormState> formKey = GlobalKey();

  final ImagePicker _picker = ImagePicker();

  //images
  File? imageFile;

  //documents
  String? pdfPath;
  String? pathPDF;

  void _getImgFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 320,
      maxHeight: 320,
    );
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      imageNameController!.text = pickedFile.name;
      String imageUrl = await _uploadImage(file);
      setState(() {
        imageFile = file;
        imageNameController!.text = imageUrl;
      });
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('task/img/${imageNameController!.text}');
    firebase_storage.UploadTask uploadTask =
        storageReference.putFile(imageFile);
    await uploadTask;

    String imageUrl = await storageReference.getDownloadURL();

    return imageUrl;
  }

  Future<void> _selectPdfFile() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      if (pickedFile.files.isNotEmpty) {
        File file = File(pickedFile.files.first.path!);
        fileNameController!.text = pickedFile.files.first.name;
        await _uploadPDFFile(file);
      }
    }
  }

  Future<void> _uploadPDFFile(File file) async {
    try {
      final firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('task/files/${fileNameController!.text}');

      final firebase_storage.UploadTask uploadTask = storageRef.putFile(file);

      final firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);

      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        pdfPath = downloadUrl;
      });
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Ошибка'),
          content: Text('Произошла ошибка при загрузке файла: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    if (widget.taskEntity.imageUrl != null) {
      imageNameController =
          TextEditingController(text: widget.taskEntity.imageUrl);
    }
    imageNameController =
        TextEditingController(text: widget.taskEntity.imageUrl);
    if (widget.taskEntity.fileUrl != null) {
      fileNameController =
          TextEditingController(text: widget.taskEntity.fileName);
    }
    fileNameController =
        TextEditingController(text: widget.taskEntity.fileName);
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Редактировать журнал"),
        actions: [
          IconButton(
            onPressed: () {
              if (titleController!.text.isNotEmpty &&
                  commentsController!.text.isNotEmpty) {
                context.read<DetailTaskCubit>().updateTask({
                  "title": titleController?.text,
                  "content": commentsController?.text,
                  "startOfWork": startWorkDateTime.toString(),
                  "endOfWork": endWorkDateTime.toString(),
                  "imageUrl": imageNameController!.text,
                  "fileUrl": pdfPath,
                  "fileName": fileNameController!.text,
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
              } else {
                AppSnackBar.showSnackBarWithMessage(
                    context, "Укажите название и комментарий к журналу");
              }
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
                                          DateTimeService()
                                              .getStartWorkDateTime(
                                                  startWorkDateTime),
                                          style: theme.textTheme.bodyMedium,
                                        ))
                                      : const SizedBox(),
                                ],
                              ),
                              MaterialButton(
                                onPressed: () async {
                                  await DateTimeService.selectStartWorkDateTime(
                                      context, startWorkDateTime,
                                      (DateTime dateTime) {
                                    setState(() {
                                      startWorkDateTime = dateTime;
                                    });
                                  });
                                  setState(() {
                                    showStartWorkDateTime = true;
                                  });
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
                                          DateTimeService().getEndWorkDateTime(
                                              endWorkDateTime),
                                          style: theme.textTheme.bodyMedium,
                                        ))
                                      : const SizedBox(),
                                ],
                              ),
                              MaterialButton(
                                onPressed: () async {
                                  await DateTimeService.selectEndWorkDateTime(
                                      context, endWorkDateTime,
                                      (DateTime dateTime) {
                                    setState(() {
                                      endWorkDateTime = dateTime;
                                    });
                                  });
                                  setState(() {
                                    showEndWorkDateTime = true;
                                  });
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
                  child: imageNameController!.text.isEmpty && imageFile == null
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
                      : SizedBox(
                          child: imageFile == null
                              ? Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Фото',
                                          style: theme.textTheme.headlineSmall),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            widget.taskEntity.imageUrl!,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                              _getImgFromGallery();
                                            },
                                            child: Text(
                                              'Выбрать другой медиафайл',
                                              style:
                                                  theme.textTheme.labelMedium,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                imageNameController!.clear();
                                                imageFile == null;
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
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Фото',
                                          style: theme.textTheme.headlineSmall),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.file(
                                            imageFile!,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                              _getImgFromGallery();
                                            },
                                            child: Text(
                                              'Выбрать другой медиафайл',
                                              style:
                                                  theme.textTheme.labelMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
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
                                    _selectPdfFile();
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
                          content: widget.taskEntity.fileUrl != null
                              ? SizedBox(
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
                                                      FileImgStorage()
                                                          .createFileOfPdfUrl(
                                                              widget.taskEntity
                                                                  .fileUrl!)
                                                          .then((path) {
                                                        setState(() {
                                                          pathPDF = path;
                                                        });
                                                      });
                                                      if (pathPDF != null) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PDFScreen(
                                                                      path:
                                                                          pathPDF!)),
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
                                )
                              : SizedBox(
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
                                                      FileImgStorage()
                                                          .createFileOfPdfUrl(
                                                              pdfPath!)
                                                          .then((path) {
                                                        setState(() {
                                                          pathPDF = path;
                                                          pdfPath = path;
                                                        });
                                                      });
                                                      if (pathPDF != null) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PDFScreen(
                                                                      path:
                                                                          pathPDF!)),
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
                                                        pathPDF = null;
                                                        pdfPath = null;
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
