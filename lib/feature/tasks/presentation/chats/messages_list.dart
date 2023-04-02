import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              shrinkWrap: true,
              reverse: true,
              itemCount: state.messageList.length + 1,
              separatorBuilder: (context, index) {
                if (index == state.messageList.length - 1) {
                  return SizedBox(
                    child: Text(state.messageList[index].sentTo.toString()),
                  );
                }
                if (state.messageList.length == 1) {
                  return const SizedBox.shrink();
                } else if (index >= state.messageList.length - 1) {
                  return const SizedBox.shrink();
                } else if (index <= state.messageList.length) {
                  final message = state.messageList[index];
                  final nextMessage = state.messageList[index + 1];
                  if ((message.sentTo.toLocal().toString() ==
                      nextMessage.sentTo.toLocal().toString())) {
                    return SizedBox(
                      child: Text(message.sentTo.day.toString()),
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
        return const SizedBox(
          child: Text("Сообщений нет"),
        );
      },
    );
  }
}
