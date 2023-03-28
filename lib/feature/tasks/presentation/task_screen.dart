import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/app/domain/error_entity/error_entity.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/app/presentation/components/AppSnackBar.dart';
import 'package:planner_etp/feature/profile/profile_screen.dart';
import 'package:planner_etp/feature/tasks/domain/state/detail/detail_task_cubit.dart';
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
      DetailTaskCubit(locator.get<TaskRepository>(), id)..fetchTasks(),
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
                      CircleAvatar(radius: 16, child: Text(taskEntity.id.toString())),
                      const SizedBox(width: 8),
                      Text(taskEntity.title, style: theme.appBarTheme.toolbarTextStyle),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )),
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
      body: BlocConsumer<DetailTaskCubit, DetailTaskState>(
        listener: (context, state) {
          if (state.asyncSnapshot.hasError) {
            AppSnackBar.showSnackBarWithError(
                context, ErrorEntity.fromException(state.asyncSnapshot.error));
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state.taskEntity != null) {
            return _DetailTaskItem(
              taskEntity: state.taskEntity!,
            );
          }
          if (state.asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const AppLoader();
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
      return 'select date timer';
    } else {
      return DateFormat('yyyy-MM-dd kk:mm').format(startWorkDateTime);
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
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text("${taskEntity.category?.name}", style: theme.textTheme.headlineSmall),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(taskEntity.title, style: theme.textTheme.bodyMedium),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit, color: Color(0xFF0d74ba)),
                          ),
                        ],
                      ),
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
                              showStartWorkDateTime
                                  ? const Icon(Icons.date_range_outlined,
                                  color: Color(0xFF0d74ba))
                                  : Flexible(child: Text(taskEntity.startOfWork.toString().split(".")[0], textAlign: TextAlign.center)),
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
                                  horizontal: 3.0),
                              child: Text(
                                'Редактировать\nдату и время',
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
                              showEndWorkDateTime
                                  ? const Icon(Icons.date_range_outlined,
                                  color: Color(0xFF0d74ba))
                                  : Flexible(child: Text(taskEntity.endOfWork.toString().split(".")[0], textAlign: TextAlign.center)),
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
                                  horizontal: 3.0),
                              child: Text(
                                'Редактировать\nдату и время',
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
          ],
        ),
      ),
    );

    //     Text("Created at: ${taskEntity.createdAt}"),
    //     Text("Компания исполнитель: ${taskEntity.contractorCompany}"),
    //     Text("Ответственный мастер: ${taskEntity.responsibleMaster}"),
    //     Text("Представитель: ${taskEntity.representative}"),
    //     Text("Уровень оснащения: ${taskEntity.equipmentLevel}"),
    //     Text("Уровень песонала: ${taskEntity.staffLevel}"),
    //     Text("Результаты работы: ${taskEntity.resultsOfTheWork}"),
    //     Text("Комментарии: ${taskEntity.content}"),
    //     Text("Создал: ${taskEntity.user?.username}"),
  }
}
