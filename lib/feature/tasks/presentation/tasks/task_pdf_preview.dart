import 'package:flutter/material.dart';
import 'package:planner_etp/feature/tasks/domain/image_storage_service.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:printing/printing.dart';

class TaskPdfPreview extends StatelessWidget {
  const TaskPdfPreview({super.key, required this.id, required this.taskEntity});

  final String id;
  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        title: Text('${taskEntity.title}.pdf'),
      ),
      body: PdfPreview(
        build: (context) => storage.generatePdf(taskEntity),
      ),
    );
  }

}