import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:planner_etp/feature/tasks/domain/pdf_storage_service.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:printing/printing.dart';

class TaskPdfPreview extends StatelessWidget {
  TaskPdfPreview({super.key, required this.taskEntity});

  final TaskEntity taskEntity;

  final PdfStorage storage = PdfStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${taskEntity.title}.pdf'),
        actions: [
          IconButton(
            onPressed: () async {
              await uploadPdfToStorage(context);
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

  Future<void> uploadPdfToStorage(BuildContext context) async {
    final pdfBytes = await storage.generatePdf(taskEntity);
    final pdfFileName = '${taskEntity.title}.pdf';

    final firebase_storage.Reference storageRef =
    firebase_storage.FirebaseStorage.instance.ref().child('task/files/$pdfFileName');

    final firebase_storage.UploadTask uploadTask = storageRef.putData(pdfBytes);
    final firebase_storage.TaskSnapshot taskSnapshot =
    await uploadTask.whenComplete(() {});

    final String fileUrl = await taskSnapshot.ref.getDownloadURL();

    context.read<TaskCubit>().createDocument({
      "name": pdfFileName,
      "filePath": fileUrl,
      "idTask": taskEntity.id,
    }).then((_) {
      context.read<TaskCubit>().fetchDocuments();
    });
  }
}
