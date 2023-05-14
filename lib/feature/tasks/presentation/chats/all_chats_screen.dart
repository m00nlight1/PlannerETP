import 'package:flutter/material.dart';
import 'package:planner_etp/feature/tasks/presentation/chats/chats_list.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Обсуждения"),
      ),
      body: const ChatsList(),
    );
  }
}
