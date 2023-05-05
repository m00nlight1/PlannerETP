import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';

class FileImgStorage {
  Future<String>? imgDownload;

  final FirebaseStorage storage = FirebaseStorage.instance;

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rand = Random();

  Future<void> uploadPdfFile(
      String fileName, File file, SettableMetadata metadata) async {
    try {
      await storage.ref('task/files/$fileName').putFile(file, metadata);
    } on FirebaseException catch (e) {
      print("Failed with error '${e.code}': ${e.message}");
    }
  }

  Future<void> uploadImage(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      await storage.ref('task/img/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print("Failed with error '${e.code}': ${e.message}");
    }
  }

  Future<void> uploadImageFromMessage(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      await storage.ref('message/img/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print("Failed with error '${e.code}': ${e.message}");
    }
  }

  Future<String> downloadImage(String fileName) async {
    String downloadUrl =
        await storage.ref('task/img/$fileName').getDownloadURL();
    return downloadUrl;
  }

  Future<String> downloadImageFromMessage(String fileName) async {
    String downloadUrl =
        await storage.ref('message/img/$fileName').getDownloadURL();
    return downloadUrl;
  }

  Future<String> downloadPdfFile(String fileName) async {
    String downloadUrl =
        await storage.ref('task/files/$fileName').getDownloadURL();
    return downloadUrl;
  }

  Future<String> downloadPdfFilePath(String fileName) async {
    FullMetadata metadata =
        await storage.ref('task/files/$fileName').getMetadata();
    final path = metadata.contentType ?? "";
    return path;
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rand.nextInt(_chars.length))));
}
