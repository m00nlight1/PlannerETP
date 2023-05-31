import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/app/domain/app_notifications.dart';
import 'package:planner_etp/app/presentation/components/bar_action_button.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/state/detail/detail_task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ActionBar extends StatefulWidget {
  final TaskEntity taskEntity;

  const ActionBar({Key? key, required this.taskEntity}) : super(key: key);

  @override
  ActionBarState createState() => ActionBarState();
}

class ActionBarState extends State<ActionBar> {
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  final messageController = TextEditingController();
  final imageNameController = TextEditingController();

  final userId = locator
      .get<AuthCubit>()
      .state
      .whenOrNull(authorized: (userEntity) => userEntity);

  Future<void> _sendMessage() async {
    context.read<DetailTaskCubit>().sentMessage({
      "content": messageController.text,
      "imageUrl": imageNameController.text,
      "idTask": widget.taskEntity.id,
    }).then((_) {
      context.read<TaskCubit>().fetchChats();
      messageController.clear();
      imageNameController.clear();
      FocusScope.of(context).unfocus();
      context.read<DetailTaskCubit>().getTaskChat();
    });
  }

  // void takeImageFromCamera() async {
  //   XFile? image =
  //   await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
  //   imageFile = File(image!.path);
  // }

  void _getImgFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 320,
      maxHeight: 320,
    );
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      imageNameController.text = pickedFile.name;
      String imageUrl = await _uploadImage(file);
      setState(() {
        imageFile = file;
        imageNameController.text = imageUrl;
      });
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('task/img/${imageNameController.text}');
    firebase_storage.UploadTask uploadTask =
    storageReference.putFile(imageFile);
    await uploadTask;

    String imageUrl = await storageReference.getDownloadURL();

    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Column(
        children: [
          Container(
            child: imageNameController.text.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.file(
                                  imageFile!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 70),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                imageFile == null;
                                imageNameController.clear();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: EdgeInsets.zero,
                                backgroundColor: Colors.grey.shade300,
                                foregroundColor: Colors.grey),
                            child: const Icon(
                              Icons.clear,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.only(left: 20, right: 16.0, top: 10.0),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 2,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    _getImgFromGallery();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(),
                    child: Icon(
                      Icons.attach_file,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 15.0),
                  child: TextField(
                    controller: messageController,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Введите сообщение...',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    onSubmitted: (_) {
                      _sendMessage();
                      AppNotifications().showNotification(
                          title: "Новое сообщение",
                          body:
                          "${userId?.username}: ${messageController.text}");
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 12, right: 24.0, top: 15.0),
                child: BarActionButton(
                    color: const Color(0xFF0d74ba),
                    icon: Icons.send_rounded,
                    onPressed: () {
                      if (imageNameController.text.isNotEmpty ||
                          messageController.text.isNotEmpty) {
                        _sendMessage();
                        AppNotifications().showNotification(
                            title: "Новое сообщение",
                            body:
                            "${userId?.username}: ${messageController.text}");
                      }
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
