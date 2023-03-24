import 'package:flutter/material.dart';
import 'package:planner_etp/feature/profile/profile_screen.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    );
  }
}