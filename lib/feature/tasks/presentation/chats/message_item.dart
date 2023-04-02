import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';
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
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        final userEntity = state.whenOrNull(
          authorized: (userEntity) => userEntity,
        );
        if (userEntity?.userState?.connectionState == ConnectionState.waiting) {
          return const AppLoader();
        }
        return Align(
          alignment: messageEntity.user?.id == userEntity?.id
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Card(
            elevation: 8,
            color: Colors.white,
            child: Column(children: [
              Text(messageEntity.content),
              Text(messageEntity.user?.email ?? ""),
            ]),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
