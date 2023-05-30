import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/app/presentation/components/search_text_field.dart';
import 'package:planner_etp/feature/tasks/domain/chat/message_entity.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';
import 'package:planner_etp/feature/tasks/presentation/chats/chat_item.dart';

class ChatsList extends StatefulWidget {
  const ChatsList({super.key});

  @override
  State<StatefulWidget> createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  TextEditingController textSearchEditingController = TextEditingController();
  List<MessageEntity?> result = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.chatsList.isNotEmpty) {
          List<MessageEntity> list = state.chatsList.toList();
          list.sort((a, b) => b.id.compareTo(a.id));

          final filterChatList = state.taskList.map((item) {
            var listObj =
                list.firstWhereOrNull((value) => value.task?.id == item.id);
            return listObj;
          }).toList();
          filterChatList.removeWhere((item) => item == null);
          filterChatList.sort((a, b) => b!.id.compareTo(a!.id));

          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchTextField(
                        controller: textSearchEditingController,
                        onChange: (value) {
                          if (textSearchEditingController.text.isEmpty) {
                            result = state.chatsList;
                            context.read<TaskCubit>().fetchChats();
                          } else {
                            result = filterChatList
                                .where((element) => element!.task!.title
                                    .toLowerCase()
                                    .contains(textSearchEditingController.text
                                        .toLowerCase()))
                                .toList();
                            context.read<TaskCubit>().fetchChats();
                          }
                        }),
                  ],
                ),
              ),
              if (textSearchEditingController.text.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return ChatItem(messageEntity: result[index]!);
                    },
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filterChatList.length,
                    itemBuilder: (context, index) {
                      return ChatItem(messageEntity: filterChatList[index]!);
                    },
                  ),
                ),
            ],
          );
        }
        if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) {
          return const AppLoader();
        }
        return SizedBox(
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
              child: Text(
                "Список чатов пуст",
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
