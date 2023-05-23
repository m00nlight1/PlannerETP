import 'package:flutter/material.dart';
import 'package:planner_etp/feature/tasks/presentation/tasks/task_list.dart';

import 'add_task_screen.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Задачи"),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTaskScreen(),
                  )),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: const TaskList(),
      ),
    );
  }

}