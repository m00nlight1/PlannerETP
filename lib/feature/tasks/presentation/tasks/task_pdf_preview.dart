import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:planner_etp/feature/tasks/domain/pdf_storage_service.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:printing/printing.dart';

class TaskPdfPreview extends StatelessWidget {
  const TaskPdfPreview({super.key, required this.taskEntity});

  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    final PdfStorage storage = PdfStorage();
    var box = Hive.box('pdf');
    var filePath = box.get('path');
    return Scaffold(
      appBar: AppBar(
        title: Text('${taskEntity.title}.pdf'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<TaskCubit>().createDocument({
                "name": taskEntity.title,
                "filePath": filePath.toString(),
                "idTask": taskEntity.id,
              }).then((_) {
                context.read<TaskCubit>().fetchDocuments();
              });
            },
            icon: const Icon(Icons.upload_file),
          ),
        ],
      ),
      body: PdfPreview(
        build: (context) => storage.generatePdf(taskEntity),
      ),
    );
  }
}
