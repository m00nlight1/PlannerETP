import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner_etp/app/presentation/components/AuthTextField.dart';
import 'package:planner_etp/feature/profile/profile_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
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
  final GlobalKey<FormState> formKey = GlobalKey();

  // Select for Date
  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

  // Select for Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
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
    if (date == null) return;
    final time = await _selectTime(context);

    if (time == null) return;
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
    if (date == null) return;
    final time = await _selectTime(context);

    if (time == null) return;
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

  String getStartWorkDateTime() {
    if (startWorkDateTime == null) {
      return 'select date timer';
    } else {
      return DateFormat('yyyy-MM-dd – kk:mm').format(startWorkDateTime);
    }
  }

  String getEndWorkDateTime() {
    if (endWorkDateTime == null) {
      return 'select date timer';
    } else {
      return DateFormat('yyyy-MM-dd – kk:mm').format(endWorkDateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создать задачу"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                )),
            icon: const Icon(Icons.account_circle),
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
                AuthTextField(
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
                AuthTextField(
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
                AuthTextField(
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
                AuthTextField(
                    hintText: 'Представитель',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.rate_review_outlined,
                        color: Color(0xFF0d74ba)),
                    controller: representativeController,
                    validator: (representative) => representative != null
                        ? 'Укажите представителя'
                        : null),
                const SizedBox(height: 10),
                //equipment level
                AuthTextField(
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
                AuthTextField(
                    hintText: 'Уровень песонала',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
