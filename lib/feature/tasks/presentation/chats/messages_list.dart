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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.messageList.length,
              itemBuilder: (context, index) {
                return MessageItem(messageEntity: state.messageList[index]);
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
