import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner_etp/feature/tasks/domain/chat/message_entity.dart';

class ChatItem extends StatefulWidget {
  final MessageEntity messageEntity;

  const ChatItem({super.key, required this.messageEntity});

  @override
  State<StatefulWidget> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Card(
          child: ListTile(
            title: Text(widget.messageEntity.task!.title,
                style: theme.textTheme.headlineSmall),
            subtitle: Row(
              children: [
                Text(DateFormat.yMMMd("ru").format(widget.messageEntity.sentTo),
                    style: theme.textTheme.bodyMedium),
                const SizedBox(width: 5),
                Text(widget.messageEntity.user!.username!,
                    style: theme.textTheme.bodyMedium),
                Text(widget.messageEntity.content!,
                    style: theme.textTheme.bodyMedium),
              ],
            ),
            // trailing: const Icon(
            //   Icons.arrow_forward_ios,
            //   color: Colors.grey,
            //   size: 20,
            // ),
          ),
        ),
      ),
    );
  }
}
