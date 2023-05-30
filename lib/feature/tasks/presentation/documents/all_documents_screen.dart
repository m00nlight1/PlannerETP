import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';
import 'package:planner_etp/feature/tasks/presentation/documents/documents_list.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AllDocumentsScreen extends StatefulWidget {
  const AllDocumentsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AllDocumentsScreenState();
}

class _AllDocumentsScreenState extends State<AllDocumentsScreen> {
  String? pdfPath;

  final fileNameController = TextEditingController();

  Future<void> _createDocument() async {
    context.read<TaskCubit>().createDocument({
      "name": fileNameController.text,
      "filePath": pdfPath,
      "idTask": null,
    }).then((_) {
      context.read<TaskCubit>().fetchDocuments();
    });
    fileNameController.clear();
  }

  Future<void> _selectPdfFile() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      if (pickedFile.files.isNotEmpty) {
        File file = File(pickedFile.files.first.path!);
        fileNameController.text = pickedFile.files.first.name;
        await _uploadPDFFile(file);
      }
      _createDocument();
    }
  }

  Future<void> _uploadPDFFile(File file) async {
    try {
      final firebase_storage.Reference storageRef =
      firebase_storage.FirebaseStorage.instance.ref().child('task/files/${fileNameController.text}');

      final firebase_storage.UploadTask uploadTask = storageRef.putFile(file);

      final firebase_storage.TaskSnapshot taskSnapshot =
      await uploadTask.whenComplete(() => null);

      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        pdfPath = downloadUrl;
      });
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Ошибка'),
          content: Text('Произошла ошибка при загрузке файла: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
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
              _selectPdfFile();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const DocumentsList(),
    );
  }
}
