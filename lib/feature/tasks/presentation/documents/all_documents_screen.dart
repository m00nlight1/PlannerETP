import 'package:flutter/material.dart';
import 'package:planner_etp/feature/tasks/presentation/documents/documents_list.dart';

class AllDocumentsScreen extends StatelessWidget {
  const AllDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Документы"),
        actions: [
          IconButton(
            onPressed: () {},
            // onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const AddTaskScreen(),
            //     )),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const DocumentsList(),
    );
  }

}