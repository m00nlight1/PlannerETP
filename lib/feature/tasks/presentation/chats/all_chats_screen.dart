import 'package:flutter/material.dart';
import 'package:planner_etp/app/domain/app_notifications.dart';
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
        actions: [
          IconButton(onPressed: () {
            AppNotifications().showNotification(title: "asdda", body: "asdad");
          }, icon: Icon(Icons.ac_unit))
        ],
      ),
      body: const ChatsList(),
    );
  }
}
