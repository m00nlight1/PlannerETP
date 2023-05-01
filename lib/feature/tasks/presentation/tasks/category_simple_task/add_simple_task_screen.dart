import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:planner_etp/app/presentation/components/app_text_field.dart';
import 'package:planner_etp/feature/tasks/domain/image_storage_service.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';

class AddSimpleTaskScreen extends StatefulWidget {
  const AddSimpleTaskScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddSimpleTaskScreenState();
}

class _AddSimpleTaskScreenState extends State<AddSimpleTaskScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime endWorkDateTime = DateTime.now();
  bool showDate = false;
  bool showTime = false;
  bool showEndWorkDateTime = false;

  final titleController = TextEditingController();
  final masterController = TextEditingController();
  final commentsController = TextEditingController();
  final imageNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  final ImgStorage storage = ImgStorage();
  final ImagePicker _picker = ImagePicker();

  File? imageFile;

  int? selectedItemId;

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
        title: const Text("Создать задачу"),
        actions: [
          IconButton(
            onPressed: () {
              if (imageFile != null && imageNameController.text.isNotEmpty) {
                storage.uploadImage(imageFile!.path, imageNameController.text);
              }
              context.read<TaskCubit>().createTask({
                "title": titleController.text,
                "content": commentsController.text,
                "startOfWork": selectedDate.toString(),
                "endOfWork": endWorkDateTime.toString(),
                "imageUrl": imageNameController.text,
                "contractorCompany": null,
                "responsibleMaster": masterController.text,
                "representative": null,
                "equipmentLevel": null,
                "staffLevel": null,
                "resultsOfTheWork": null,
                "expenses": null,
                "idCategory": 3,
                "idStatus": selectedItemId,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Center(
                                child: Text(
                                  'Установить дату и время',
                                  style: theme.textTheme.labelMedium,
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
                AppTextField(
                    hintText: 'Ответственное лицо',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.perm_identity,
                        color: Color(0xFF0d74ba)),
                    controller: masterController,
                    validator: (master) => master != null
                        ? 'Укажите ответственное лицо'
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
                                        elevation: 0
                                      ),
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