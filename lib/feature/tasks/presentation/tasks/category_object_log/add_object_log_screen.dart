import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/app/domain/app_notifications.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/app/presentation/components/app_snack_bar.dart';
import 'package:planner_etp/app/presentation/components/app_text_field.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:planner_etp/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:planner_etp/feature/tasks/domain/datetime_service.dart';
import 'package:planner_etp/feature/tasks/presentation/pdf_viewer_screen.dart';
import 'package:planner_etp/feature/tasks/domain/firebase_storage_service.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart' as tc;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddObjectLogScreen extends StatefulWidget {
  const AddObjectLogScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddObjectLogScreenState();
}

class _AddObjectLogScreenState extends State<AddObjectLogScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime startWorkDateTime = DateTime.now();
  DateTime endWorkDateTime = DateTime.now();
  bool showDate = false;
  bool showTime = false;
  bool showStartWorkDateTime = false;
  bool showEndWorkDateTime = false;

  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final masterController = TextEditingController();
  final representativeController = TextEditingController();
  final equipmentLevelController = TextEditingController();
  final staffLevelController = TextEditingController();
  final resultsOfTheWorkController = TextEditingController();
  final commentsController = TextEditingController();
  final imageNameController = TextEditingController();
  final fileNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  final FileImgStorage storage = FileImgStorage();
  final ImagePicker _picker = ImagePicker();

  File? imageFile;
  String? pdfPath;
  String? pathPDF;

  List<UserEntity> userList = [];
  final userId = locator
      .get<AuthCubit>()
      .state
      .whenOrNull(authorized: (userEntity) => userEntity);

  void _getImgFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 320,
      maxHeight: 320,
    );
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      imageNameController.text = pickedFile.name;
      String imageUrl = await _uploadImage(file);
      setState(() {
        imageFile = file;
        imageNameController.text = imageUrl;
      });
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('task/img/${imageNameController.text}');
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
        fileNameController.text = pickedFile.files.first.name;
        await _uploadPDFFile(file);
      }
    }
  }

  Future<void> _uploadPDFFile(File file) async {
    try {
      final firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('task/files/${fileNameController.text}');

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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создать журнал"),
        actions: [
          BlocConsumer<tc.TaskCubit, tc.TaskState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.usersList.isNotEmpty) {
                userList = state.usersList.toList();
                return IconButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        commentsController.text.isNotEmpty) {
                      context.read<tc.TaskCubit>().createTask({
                        "title": titleController.text,
                        "content": commentsController.text,
                        "startOfWork": startWorkDateTime.toString(),
                        "endOfWork": endWorkDateTime.toString(),
                        "imageUrl": imageNameController.text,
                        "fileUrl": pdfPath,
                        "fileName": fileNameController.text,
                        "contractorCompany": companyController.text,
                        "responsibleMaster": masterController.text,
                        "representative": representativeController.text,
                        "equipmentLevel": equipmentLevelController.text,
                        "staffLevel": staffLevelController.text,
                        "resultsOfTheWork": resultsOfTheWorkController.text,
                        "expenses": null,
                        "idCategory": 1,
                        "idStatus": null,
                        "idIndustry": null,
                        "idTaskType": null
                      }).then((_) {
                        if (userList.map((e) => e.id).contains(userId!.id)) {
                          AppNotifications().showNotification(
                              title: "Новая задача",
                              body:
                                  "Пользователь ${userId?.username} добавил «${titleController.text}: ${commentsController.text}»");
                        } else {
                          AppNotifications().showNotification(
                              title: "Новая задача",
                              body:
                                  "Пользователь ${userId?.username} добавил «${titleController.text}: ${commentsController.text}»");
                        }
                      });
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      AppSnackBar.showSnackBarWithMessage(
                          context, "Укажите название и комментарий к журналу");
                    }
                  },
                  icon: const Icon(Icons.done),
                );
              }
              if (state.asyncSnapshot?.connectionState ==
                  ConnectionState.waiting) {
                return const AppLoader();
              }
              return const SizedBox.shrink();
            },
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
                AppTextField(
                  hintText: 'Название',
                  obscureText: false,
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.rate_review_outlined,
                      color: Color(0xFF0d74ba)),
                  controller: titleController,
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
                                      : const SizedBox(),
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
                                    'Установить\nдату и время',
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
                                      : const SizedBox(),
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
                                    'Установить\nдату и время',
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
                AppTextField(
                  hintText: 'Компания исполнитель',
                  obscureText: false,
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.rate_review_outlined,
                      color: Color(0xFF0d74ba)),
                  controller: companyController,
                  validator: (company) =>
                      company != null ? 'Укажите компанию исполнителя' : null,
                  minLines: 1,
                ),
                const SizedBox(height: 10),
                //responsible master
                AppTextField(
                  hintText: 'Ответственный мастер',
                  obscureText: false,
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.rate_review_outlined,
                      color: Color(0xFF0d74ba)),
                  controller: masterController,
                  validator: (master) =>
                      master != null ? 'Укажите ответственного мастера' : null,
                  minLines: 1,
                ),
                const SizedBox(height: 10),
                //representative
                AppTextField(
                  hintText: 'Представитель',
                  obscureText: false,
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.rate_review_outlined,
                      color: Color(0xFF0d74ba)),
                  controller: representativeController,
                  validator: (representative) =>
                      representative != null ? 'Укажите представителя' : null,
                  minLines: 1,
                ),
                const SizedBox(height: 10),
                //images
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    color: Colors.grey.shade200,
                    child: imageNameController.text.isEmpty
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
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Фото',
                                    style: theme.textTheme.headlineSmall),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.file(
                                      imageFile!,
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
                                        style: theme.textTheme.labelMedium,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          imageNameController.clear();
                                          imageFile == null;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
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
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                //equipment level
                AppTextField(
                  hintText: 'Уровень оснащения',
                  obscureText: false,
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.rate_review_outlined,
                      color: Color(0xFF0d74ba)),
                  controller: equipmentLevelController,
                  validator: (equipmentLevel) => equipmentLevel != null
                      ? 'Укажите уровень оснащения'
                      : null,
                  minLines: 1,
                ),
                const SizedBox(height: 10),
                //staff level
                AppTextField(
                  hintText: 'Уровень персонала',
                  obscureText: false,
                  maxLines: 1,
                  prefixIcon: const Icon(Icons.rate_review_outlined,
                      color: Color(0xFF0d74ba)),
                  controller: staffLevelController,
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
                const SizedBox(height: 10),
                //documents
                Card(
                  color: Colors.grey.shade200,
                  child: fileNameController.text.isEmpty
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
                      : SizedBox(
                          width: 342,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Text(fileNameController.text),
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
                                                  fileNameController.clear();
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
