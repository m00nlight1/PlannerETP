import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/app/domain/error_entity/error_entity.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/app/presentation/components/app_snack_bar.dart';
import 'package:planner_etp/app/presentation/components/message_action_bar.dart';
import 'package:planner_etp/feature/tasks/domain/image_storage_service.dart';
import 'package:planner_etp/feature/tasks/domain/state/detail/detail_task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/domain/task_repository.dart';
import 'package:planner_etp/feature/tasks/presentation/chats/task_chat_screen.dart';
import 'package:planner_etp/feature/tasks/presentation/tasks/category_simple_task/update_simple_task_screen.dart';
import 'package:planner_etp/feature/tasks/presentation/tasks/task_pdf_preview.dart';

class DetailSimpleTaskScreen extends StatelessWidget {
  final String id;
  final TaskEntity taskEntity;

  const DetailSimpleTaskScreen(
      {super.key, required this.id, required this.taskEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailTaskCubit(locator.get<TaskRepository>(), id)..fetchTask(),
      child: _DetailTaskView(taskEntity, id),
    );
  }
}

class _DetailTaskView extends StatelessWidget {
  const _DetailTaskView(this.taskEntity, this.id);

  final String id;
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
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TaskPdfPreview(taskEntity: taskEntity))),
            icon: const Icon(Icons.picture_as_pdf),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    TaskChatScreen(taskEntity: taskEntity, id: id))),
            icon: const Icon(Icons.message_rounded),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    UpdateSimpleTaskScreen(id: id, taskEntity: taskEntity))),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              context.read<DetailTaskCubit>().deleteTask().then((_) {
                context.read<TaskCubit>().fetchTasks();
                Navigator.of(context).pop();
              });
            },
            icon: const Icon(Icons.delete),
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
            return Column(
              children: [
                Expanded(
                  child: _DetailTaskItem(taskEntity: state.taskEntity!),
                ),
                //sent message action bar
                ActionBar(taskEntity: taskEntity),
              ],
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
  State<StatefulWidget> createState() => _DetailTaskItemState();
}

class _DetailTaskItemState extends State<_DetailTaskItem> {
  final ImgStorage storage = ImgStorage();
  Future<String>? imgDownload;

  @override
  void initState() {
    if (widget.taskEntity.imageUrl != null) {
      imgDownload = storage.downloadImage(widget.taskEntity.imageUrl ?? "");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text("${widget.taskEntity.category?.name}",
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
                        Text(widget.taskEntity.title,
                            style: theme.textTheme.bodyMedium),
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
                        Text('Описание', style: theme.textTheme.headlineSmall),
                        Flexible(
                          child: Text(widget.taskEntity.content ?? "Не указано",
                              style: theme.textTheme.bodyMedium),
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
                  width: 370,
                  height: 90,
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
                            const Icon(Icons.date_range_outlined,
                                color: Color(0xFF0d74ba)),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                widget.taskEntity.endOfWork
                                    .toString()
                                    .split(".")[0],
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
                        Text('Ответственное лицо',
                            style: theme.textTheme.headlineSmall),
                        Row(
                          children: [
                            const Icon(Icons.perm_identity,
                                color: Color(0xFF0d74ba)),
                            const SizedBox(width: 10),
                            Text(
                                widget.taskEntity.responsibleMaster ??
                                    "Не указано",
                                style: theme.textTheme.bodyMedium),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //image
              Card(
                margin: const EdgeInsets.only(left: 12, right: 12),
                color: Colors.grey.shade200,
                child: widget.taskEntity.imageUrl == null
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
                        content: FutureBuilder(
                          future: imgDownload,
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Image.network(
                                    snapshot.data ?? "",
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
              ),
              const SizedBox(height: 10),
              //status
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
                        Text('Статус', style: theme.textTheme.headlineSmall),
                        Text(widget.taskEntity.status?.name ?? "Не указано",
                            style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //created at date and author
              Text(
                  "Создано ${widget.taskEntity.createdAt.toString().split(" ")[0]}",
                  style: theme.textTheme.bodyMedium),
              const SizedBox(height: 10),
              Text(
                  "Автор: ${widget.taskEntity.user?.username} (${widget.taskEntity.user?.email})",
                  style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
