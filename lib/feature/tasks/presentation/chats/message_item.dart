import 'package:flutter/material.dart';
import 'package:planner_etp/feature/tasks/domain/chat/message_entity.dart';

class MessageItem extends StatefulWidget {
  final MessageEntity messageEntity;

  const MessageItem({super.key, required this.messageEntity});

  @override
  State<StatefulWidget> createState() => _MessageItemState(messageEntity);
}

class _MessageItemState extends State<MessageItem> {
  final MessageEntity messageEntity;

  _MessageItemState(this.messageEntity);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Text(messageEntity.content),
    );
  }

}