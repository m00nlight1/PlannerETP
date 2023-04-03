import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/feature/tasks/domain/state/detail/detail_task_cubit.dart';
import 'package:planner_etp/feature/tasks/presentation/chats/message_item.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailTaskCubit, DetailTaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.messageList.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: ListView.separated(
              reverse: false,
              itemCount: state.messageList.length + 1,
              separatorBuilder: (context, index) {
                if (index == state.messageList.length + 1) {
                  return SizedBox(
                    child: _DateLable(dateTime: state.messageList[index].sentTo)
                  );
                }
                if (state.messageList.length == 1) {
                  return const SizedBox.shrink();
                } else if (index >= state.messageList.length - 1) {
                  return const SizedBox.shrink();
                } else if (index <= state.messageList.length) {
                  final message = state.messageList[index + 1];
                  final nextMessage = state.messageList[index];
                  if (!Jiffy(message.sentTo.toLocal()).isSame(nextMessage.sentTo.toLocal(), Units.DAY)) {
                    return _DateLable(
                      dateTime: message.sentTo.toLocal()
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
              itemBuilder: (context, index) {
                if (index < state.messageList.length) {
                  return MessageItem(messageEntity: state.messageList[index]);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          );
        }
        if (state.asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const AppLoader();
        }
        return SizedBox(
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
              child: Text(
                "Сообщений нет",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DateLable extends StatefulWidget {
  const _DateLable({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  final DateTime dateTime;

  @override
  __DateLableState createState() => __DateLableState();
}

class __DateLableState extends State<_DateLable> {
  late String dayInfo;

  @override
  void initState() {
    final sentTo = Jiffy(widget.dateTime);
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
      dayInfo = sentTo.EEEE;
    } else if (Jiffy(sentTo).isAfter(
      Jiffy(now).subtract(years: 1),
      Units.DAY,
    )) {
      dayInfo = sentTo.MMMd;
    } else {
      dayInfo = sentTo.MMMd;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              dayInfo,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
