import 'package:flutter/material.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/presentation/task_screen.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.taskEntity});

  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TaskScreen(id: taskEntity.id.toString())));
      },
      child: Card(
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
                  Text("Создано ${taskEntity.user?.id ?? ""}"),
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
      ),
    );
  }
}
