import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';

class ImgStorage {
  Future<String>? imgDownload;

  final FirebaseStorage storage = FirebaseStorage.instance;

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rand = Random();

  Future<void> uploadImage(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      await storage.ref('task/$fileName').putFile(file);
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  Future<void> uploadImageFromMessage(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      await storage.ref('message/$fileName').putFile(file);
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  Future<String> downloadImage(String fileName) async {
    String downloadUrl = await storage.ref('task/$fileName').getDownloadURL();
    return downloadUrl;
  }

  Future<String> downloadImageFromMessage(String fileName) async {
    String downloadUrl = await storage.ref('message/$fileName').getDownloadURL();
    return downloadUrl;
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rand.nextInt(_chars.length))));
}
