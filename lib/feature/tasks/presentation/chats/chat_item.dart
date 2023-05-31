import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:planner_etp/feature/tasks/domain/chat/message_entity.dart';
import 'package:planner_etp/feature/tasks/presentation/chats/task_chat_screen.dart';

class ChatItem extends StatefulWidget {
  final MessageEntity messageEntity;

  const ChatItem({super.key, required this.messageEntity});

  @override
  State<StatefulWidget> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  late String dayInfo;

  @override
  void initState() {
    final sentTo = widget.messageEntity.sentTo;
    final now = DateTime.now();

    if (Jiffy(sentTo).isSame(now, Units.DAY)) {
      dayInfo = 'Сегодня';
    } else if (Jiffy(sentTo)
        .isSame(now.subtract(const Duration(days: 1)), Units.DAY)) {
      dayInfo = 'Вчера';
    } else if (Jiffy(sentTo).isAfter(
      now.subtract(const Duration(days: 7)),
      Units.DAY,
    )) {
      dayInfo = DateFormat.EEEE("ru").format(sentTo);
    } else if (Jiffy(sentTo).isAfter(
      Jiffy(now).subtract(years: 1),
      Units.DAY,
    )) {
      dayInfo = DateFormat.MMMd("ru").format(sentTo);
    } else {
      dayInfo = DateFormat.MMMd("ru").format(sentTo);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    initializeDateFormatting("ru");
    String bodyText = widget.messageEntity.content != "" ? "${widget.messageEntity.user!.username!}: ${widget.messageEntity.content}" : "${widget.messageEntity.user!.username!}: Изображение";
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              TaskChatScreen(taskEntity: widget.messageEntity.task!, id: widget.messageEntity.task!.id.toString()))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Card(
          child: ListTile(
            title: Text(widget.messageEntity.task!.title,
                style: theme.textTheme.headlineSmall),
            leading: CircleAvatar(
              radius: 22,
              child: Text(
                  widget.messageEntity.task?.title.split("").first ??
                      "Нет данных",
                  style: theme.textTheme.bodySmall),
            ),
            subtitle: Row(
              children: [
                Flexible(
                  child: Text(
                      bodyText,
                      maxLines: 2,
                      style: theme.textTheme.bodyMedium),
                ),
              ],
            ),
            trailing: SizedBox(
              child: Text(dayInfo, style: theme.textTheme.bodyMedium),
            ),
          ),
        ),
      ),
    );
  }
}
