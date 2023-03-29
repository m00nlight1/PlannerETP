import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/app/domain/error_entity/error_entity.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/app/presentation/components/AppSnackBar.dart';
import 'package:planner_etp/feature/tasks/domain/state/detail/detail_task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/domain/task_repository.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key, required this.id, required this.taskEntity});

  final String id;
  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailTaskCubit(locator.get<TaskRepository>(), id)..fetchTask(),
      child: _DetailTaskView(taskEntity),
    );
  }
}

class _DetailTaskView extends StatelessWidget {
  const _DetailTaskView(this.taskEntity);

  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB5BEC6),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(35.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      CircleAvatar(
                          radius: 16, child: Text(taskEntity.id.toString())),
                      const SizedBox(width: 8),
                      Text(taskEntity.title,
                          style: theme.appBarTheme.toolbarTextStyle),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )),
        actions: [
          IconButton(
            onPressed: () {
              context.read<DetailTaskCubit>().deleteTask().then((_) {
                context.read<TaskCubit>().fetchTasks();
                Navigator.of(context).pop();
              });
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              context.read<DetailTaskCubit>().updateTask({
                "title": "Задача 57900",
                "content": "dadsavd",
                "startOfWork": "2023-02-20 10:10",
                "endOfWork": "2023-02-20 18:10",
                "contractorCompany": "daffdf",
                "responsibleMaster": "adfdssd",
                "representative": "dsadsad",
                "equipmentLevel": "adafdfds",
                "staffLevel": "adafdfd",
                "resultsOfTheWork": "adfdsg",
                "idCategory": 1
              }).then((_) {
                context.read<TaskCubit>().fetchTasks();
                Navigator.of(context).pop();
              });
              // showDialog(context: context, builder: (context) => _UpdateTaskDialog());
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: BlocConsumer<DetailTaskCubit, DetailTaskState>(
        listener: (context, state) {
          if (state.asyncSnapshot.hasData) {
            AppSnackBar.showSnackBarWithMessage(
                context, state.asyncSnapshot.data.toString());
          }
          if (state.asyncSnapshot.hasError) {
            AppSnackBar.showSnackBarWithError(
                context, ErrorEntity.fromException(state.asyncSnapshot.error));
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state.asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const AppLoader();
          }
          if (state.taskEntity != null) {
            return _DetailTaskItem(
              taskEntity: state.taskEntity!,
            );
          }
          return const Center(
            child: Text("Ошибка загрузки"),
          );
        },
      ),
    );
  }
}

class _DetailTaskItem extends StatefulWidget {
  const _DetailTaskItem({required this.taskEntity});

  final TaskEntity taskEntity;

  @override
  State<StatefulWidget> createState() => _DetailTaskItemState(taskEntity);
}

class _DetailTaskItemState extends State<_DetailTaskItem> {
  _DetailTaskItemState(this.taskEntity);

  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text("${taskEntity.category?.name}",
                  style: theme.textTheme.headlineSmall),
              const SizedBox(height: 10),
              //title
              Card(
                color: Colors.grey.shade200,
                child: SizedBox(
                  width: 370,
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Название', style: theme.textTheme.headlineSmall),
                        Text(taskEntity.title,
                            style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
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
                      width: 180,
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
                                const Icon(Icons.date_range_outlined,
                                    color: Color(0xFF0d74ba)),
                                Flexible(
                                    child: Text(
                                        taskEntity.startOfWork
                                            .toString()
                                            .split(".")[0],
                                        textAlign: TextAlign.center)),
                                const SizedBox(width: 5),
                              ],
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
                      width: 180,
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
                                const Icon(Icons.date_range_outlined,
                                    color: Color(0xFF0d74ba)),
                                Flexible(
                                    child: Text(
                                        taskEntity.endOfWork
                                            .toString()
                                            .split(".")[0],
                                        textAlign: TextAlign.center)),
                                const SizedBox(width: 5),
                              ],
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
              Card(
                color: Colors.grey.shade200,
                child: SizedBox(
                  width: 370,
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Компания исполнитель',
                            style: theme.textTheme.headlineSmall),
                        Text(taskEntity.contractorCompany ?? "Не указано",
                            style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //responsible master
              Card(
                color: Colors.grey.shade200,
                child: SizedBox(
                  width: 370,
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ответственный мастер',
                            style: theme.textTheme.headlineSmall),
                        Text(taskEntity.responsibleMaster ?? "Не указано",
                            style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //representative
              Card(
                color: Colors.grey.shade200,
                child: SizedBox(
                  width: 370,
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Представитель',
                            style: theme.textTheme.headlineSmall),
                        Text(taskEntity.representative ?? "Не указано",
                            style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //equipment level
              Card(
                color: Colors.grey.shade200,
                child: SizedBox(
                  width: 370,
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Уровень оснащения',
                            style: theme.textTheme.headlineSmall),
                        Text(taskEntity.equipmentLevel ?? "Не указано",
                            style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //staff level
              Card(
                color: Colors.grey.shade200,
                child: SizedBox(
                  width: 370,
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Уровень песонала',
                            style: theme.textTheme.headlineSmall),
                        Text(taskEntity.staffLevel ?? "Не указано",
                            style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //resultsOfTheWork
              Card(
                color: Colors.grey.shade200,
                child: SizedBox(
                  width: 370,
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Результаты работы',
                            style: theme.textTheme.headlineSmall),
                        Flexible(
                          child: Text(
                              taskEntity.resultsOfTheWork ?? "Не указано",
                              style: theme.textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //comments
              Card(
                color: Colors.grey.shade200,
                child: SizedBox(
                  width: 370,
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Комментарии',
                            style: theme.textTheme.headlineSmall),
                        Flexible(
                          child: Text(taskEntity.content ?? "Не указано",
                              style: theme.textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //created at date and author
              Text("Создано ${taskEntity.createdAt.toString().split(" ")[0]}",
                  style: theme.textTheme.bodyMedium),
              const SizedBox(height: 10),
              Text(
                  "Автор: ${taskEntity.user?.username} (${taskEntity.user?.email})",
                  style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpdateTaskDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpdateTaskDialogState();
}

class _UpdateTaskDialogState extends State<_UpdateTaskDialog> {
  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final masterController = TextEditingController();
  final representativeController = TextEditingController();
  final equipmentLevelController = TextEditingController();
  final staffLevelController = TextEditingController();
  final resultsOfTheWorkController = TextEditingController();
  final commentsController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime startWorkDateTime = DateTime.now();
  DateTime endWorkDateTime = DateTime.now();
  bool showDate = false;
  bool showTime = false;
  bool showStartWorkDateTime = false;
  bool showEndWorkDateTime = false;

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
      return 'Не указано';
    } else {
      return DateFormat('yyyy-MM-dd kk:mm').format(startWorkDateTime);
    }
  }

  String getEndWorkDateTime() {
    if (endWorkDateTime == null) {
      return 'Не указано';
    } else {
      return DateFormat('yyyy-MM-dd – kk:mm').format(endWorkDateTime);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    companyController.dispose();
    masterController.dispose();
    representativeController.dispose();
    equipmentLevelController.dispose();
    staffLevelController.dispose();
    resultsOfTheWorkController.dispose();
    commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
