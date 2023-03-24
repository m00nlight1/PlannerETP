import 'package:flutter/material.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.taskEntity});

  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Создано ${taskEntity.author?.id ?? ""}"),
                Text("от ${taskEntity.createdAt.toString().split(" ")[0]}"),
              ],
            ),
            const SizedBox(height: 5),
            Text(taskEntity.title, style: theme.textTheme.headlineMedium),
            const SizedBox(height: 5),
            Text(taskEntity.content ?? "",
                style: theme.textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
