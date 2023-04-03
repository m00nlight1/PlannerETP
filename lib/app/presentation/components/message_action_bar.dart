import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/app/presentation/components/bar_action_button.dart';
import 'package:planner_etp/feature/tasks/domain/state/detail/detail_task_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';

class ActionBar extends StatefulWidget {
  final TaskEntity taskEntity;

  const ActionBar({Key? key, required this.taskEntity}) : super(key: key);

  @override
  _ActionBarState createState() => _ActionBarState(taskEntity);
}

class _ActionBarState extends State<ActionBar> {
  final TaskEntity taskEntity;
  final TextEditingController messageController = TextEditingController();

  _ActionBarState(this.taskEntity);

  Future<void> _sendMessage() async {
    if (messageController.text.isNotEmpty) {
      context.read<DetailTaskCubit>().sentMessage({
        "content": messageController.text,
        "idTask": taskEntity.id,
      });
      messageController.clear();
      FocusScope.of(context).unfocus();
      context.read<DetailTaskCubit>().getTaskChat();

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     border: Border(
          //       right: BorderSide(
          //         width: 2,
          //         color: Theme.of(context).dividerColor,
          //       ),
          //     ),
          //   ),
          //   child: const Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 16.0),
          //     // child: Icon(
          //     //   Icons.add
          //     // ),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 15.0),
              child: TextField(
                controller: messageController,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Введите сообщение...',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 24.0, top: 15.0),
            child: BarActionButton(
              color: const Color(0xFF0d74ba),
              icon: Icons.send_rounded,
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}