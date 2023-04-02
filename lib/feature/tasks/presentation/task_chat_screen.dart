import 'package:flutter/material.dart';

class TaskChatScreen extends StatefulWidget {
  const TaskChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TaskChatScreenState();
}
class _TaskChatScreenState extends State<TaskChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Комментарии"),
      ),
    );
  }

}