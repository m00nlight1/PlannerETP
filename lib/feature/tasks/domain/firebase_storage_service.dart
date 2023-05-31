import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FileImgStorage {
  Future<String>? imgDownload;

  final FirebaseStorage storage = FirebaseStorage.instance;

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rand = Random();

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

  Future<String> createFileOfPdfUrl(String filePath) async {
    final url = filePath;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    final dir = await getTemporaryDirectory();
    final file = File("${dir.path}/$filename.pdf");

    if (!await file.exists()) {
      final request = await HttpClient().getUrl(Uri.parse(url));
      final response = await request.close();
      final bytes = await consolidateHttpClientResponseBytes(response);
      await file.writeAsBytes(bytes);
    }
    return file.path;
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rand.nextInt(_chars.length))));
}
