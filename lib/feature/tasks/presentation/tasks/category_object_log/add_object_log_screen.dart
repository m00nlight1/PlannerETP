import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:planner_etp/app/presentation/components/app_text_field.dart';
import 'package:planner_etp/feature/tasks/domain/image_storage_service.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';

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
  Uint8List? fileBytes;

  void _getImgFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 320,
      maxHeight: 320,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        imageNameController.text = storage.getRandomString(7);
      });
    }
  }

  void _getFile() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      setState(() {
        fileBytes = pickedFile.files.first.bytes;
        fileNameController.text = pickedFile.files.first.name;
      });
    }
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
        title: const Text("Создать журнал"),
        actions: [
          IconButton(
            onPressed: () {
              if (imageFile != null && imageNameController.text.isNotEmpty) {
                storage.uploadImage(imageFile!.path, imageNameController.text);
              }
              if (fileBytes != null && fileNameController.text.isNotEmpty) {
                storage.uploadFile(fileBytes!, fileNameController.text);
              }
              context.read<TaskCubit>().createTask({
                "title": titleController.text,
                "content": commentsController.text,
                "startOfWork": startWorkDateTime.toString(),
                "endOfWork": endWorkDateTime.toString(),
                "imageUrl": imageNameController.text,
                "fileUrl": fileNameController.text,
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
              });
              Navigator.pop(context);
              Navigator.pop(context);
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
                AppTextField(
                    hintText: 'Название',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF0d74ba)),
                    controller: titleController,
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
                                      : const SizedBox(),
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
                    prefixIcon: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF0d74ba)),
                    controller: companyController,
                    validator: (company) => company != null
                        ? 'Укажите компанию исполнителя'
                        : null),
                const SizedBox(height: 10),
                //responsible master
                AppTextField(
                    hintText: 'Ответственный мастер',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF0d74ba)),
                    controller: masterController,
                    validator: (master) => master != null
                        ? 'Укажите ответственного мастера'
                        : null),
                const SizedBox(height: 10),
                //representative
                AppTextField(
                    hintText: 'Представитель',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF0d74ba)),
                    controller: representativeController,
                    validator: (representative) => representative != null
                        ? 'Укажите представителя'
                        : null),
                const SizedBox(height: 10),
                //images
                Card(
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
                      : SizedBox(
                          width: 342,
                          height: 320,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Фото',
                                    style: theme.textTheme.headlineSmall),
                                const SizedBox(height: 10),
                                Image.file(
                                  imageFile!,
                                  fit: BoxFit.cover,
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
                    prefixIcon: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF0d74ba)),
                    controller: equipmentLevelController,
                    validator: (equipmentLevel) => equipmentLevel != null
                        ? 'Укажите уровень оснащения'
                        : null),
                const SizedBox(height: 10),
                //staff level
                AppTextField(
                    hintText: 'Уровень персонала',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF0d74ba)),
                    controller: staffLevelController,
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
                                    _getFile();
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
                                Text('Документы',
                                    style: theme.textTheme.headlineSmall),
                                const SizedBox(height: 10),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            fileNameController.text.toString()),
                                        MaterialButton(
                                          onPressed: () {},
                                          child: Text('Открыть',
                                              style: theme
                                                  .textTheme.headlineSmall),
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
