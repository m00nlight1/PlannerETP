import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:planner_etp/feature/tasks/domain/image_storage_service.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/presentation/tasks/task_screen.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.taskEntity});

  final TaskEntity taskEntity;

  @override
  State<StatefulWidget> createState() => _TaskItemState(taskEntity);
}

class _TaskItemState extends State<TaskItem> {
  final TaskEntity taskEntity;
  final Storage storage = Storage();
  Future<String>? imgDownload;

  _TaskItemState(this.taskEntity);

  @override
  void initState() {
    if (taskEntity.imageUrl != null){
      imgDownload = storage.downloadImage(taskEntity.imageUrl ?? "");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TaskScreen(
                id: taskEntity.id.toString(), taskEntity: taskEntity)));
      },
      child: GFCard(
        boxFit: BoxFit.cover,
        title: GFListTile(
          title: Text(taskEntity.title, style: theme.textTheme.headlineMedium),
        ),
        content: FutureBuilder(
          future: imgDownload,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Создано ${taskEntity.user?.username ?? ""} \n(${taskEntity.user?.email ?? ""})"),
                      Text(
                          "от ${taskEntity.createdAt.toString().split(" ")[0]}"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(taskEntity.content ?? "",
                      style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 5),
                  Image.network(
                    snapshot.data ?? "",
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Создано ${taskEntity.user?.username ?? ""} \n(${taskEntity.user?.email ?? ""})"),
                      Text(
                          "от ${taskEntity.createdAt.toString().split(" ")[0]}"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(taskEntity.content ?? "",
                      style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 5),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
