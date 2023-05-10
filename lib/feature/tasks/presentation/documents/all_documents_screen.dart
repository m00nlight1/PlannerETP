import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';
import 'package:planner_etp/feature/tasks/presentation/documents/documents_list.dart';

class AllDocumentsScreen extends StatefulWidget {
  const AllDocumentsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AllDocumentsScreenState();
}

class _AllDocumentsScreenState extends State<AllDocumentsScreen> {
  File? pdfFile;
  String? pathPdf;
  SettableMetadata? settableMetadata;

  final fileNameController = TextEditingController();

  Future<void> _createDocument() async {
    context.read<TaskCubit>().createDocument({
      "name": fileNameController.text,
      "filePath": pathPdf.toString(),
      "idTask": null,
    }).then((_) {
      context.read<TaskCubit>().fetchDocuments();
    });
    fileNameController.clear();
  }

  void _getPdfFile() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      setState(() {
        pathPdf = pickedFile.files.first.path;
        pdfFile = File(pickedFile.files.first.path!);
        settableMetadata = SettableMetadata(contentType: pathPdf);
        fileNameController.text = pickedFile.files.first.name;
      });
      _createDocument();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Документы"),
        actions: [
          IconButton(
            onPressed: () {
              _getPdfFile();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const DocumentsList(),
    );
  }
}
