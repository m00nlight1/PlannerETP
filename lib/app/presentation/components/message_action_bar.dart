import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planner_etp/app/presentation/components/bar_action_button.dart';
import 'package:planner_etp/feature/tasks/domain/image_storage_service.dart';
import 'package:planner_etp/feature/tasks/domain/state/detail/detail_task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';

class ActionBar extends StatefulWidget {
  final TaskEntity taskEntity;

  const ActionBar({Key? key, required this.taskEntity}) : super(key: key);

  @override
  ActionBarState createState() => ActionBarState();
}

class ActionBarState extends State<ActionBar> {
  final ImagePicker _picker = ImagePicker();
  final ImgStorage storage = ImgStorage();
  Future<String>? imgDownload;
  File? imageFile;
  final messageController = TextEditingController();
  final imageNameController = TextEditingController();

  Future<void> _sendMessage() async {
    if (imageFile != null && imageNameController.text.isNotEmpty) {
      storage.uploadImage(imageFile!.path, imageNameController.text);
    }
    context.read<DetailTaskCubit>().sentMessage({
      "content": messageController.text,
      "imageUrl": imageNameController.text,
      "idTask": widget.taskEntity.id,
    });
    messageController.clear();
    FocusScope.of(context).unfocus();
    context.read<DetailTaskCubit>().getTaskChat();
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
      setState(() {
        imageFile = File(pickedFile.path);
        imageNameController.text = storage.getRandomString(7);
      });
    }
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
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text('${imageNameController.text}.jpg'),
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
                    // if (imageFile != null) {
                    //   fileName = storage.getRandomString(7);
                    //   storage.uploadImage(imageFile!.path, fileName!);
                    // }
                    // context.read<DetailTaskCubit>().sentMessage({
                    //   "content": fileName.toString(),
                    //   "idTask": widget.taskEntity.id,
                    // });
                    // context.read<DetailTaskCubit>().getTaskChat();
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
                    onSubmitted: (_) => _sendMessage(),
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
                    if (imageNameController.text.isNotEmpty
                    || messageController.text.isNotEmpty) {
                      _sendMessage();
                    }
                  }
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
