import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/chat/message_entity.dart';
import 'package:planner_etp/feature/tasks/domain/firebase_storage_service.dart';

class MessageItem extends StatefulWidget {
  const MessageItem({super.key, required this.messageEntity});

  final MessageEntity messageEntity;

  @override
  State<StatefulWidget> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
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
        if (widget.messageEntity.user?.id == userEntity?.id) {
          return _MessageOwnTile(message: widget.messageEntity);
        } else {
          return _MessageTile(message: widget.messageEntity);
        }
      },
      listener: (context, state) {},
    );
  }
}

class _MessageTile extends StatefulWidget {
  const _MessageTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageEntity message;

  @override
  State<StatefulWidget> createState() => _MessageTileState();
}

class _MessageTileState extends State<_MessageTile> {
  static const _borderRadius = 26.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.message.content!,
                        style: const TextStyle(
                          color: Colors.white,
                        )),
                    widget.message.imageUrl!.isEmpty ||
                            widget.message.imageUrl == null
                        ? const SizedBox.shrink()
                        : widget.message.content!.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          _OpenImageDialog(widget.message));
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            widget.message.imageUrl!,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          _OpenImageDialog(widget.message));
                                },
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        widget.message.imageUrl!,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                Jiffy(widget.message.sentTo.toLocal()).jm,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MessageOwnTile extends StatefulWidget {
  const _MessageOwnTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageEntity message;

  @override
  State<StatefulWidget> createState() => _MessageOwnTileState();
}

class _MessageOwnTileState extends State<_MessageOwnTile> {
  final FileImgStorage storage = FileImgStorage();
  Future<String>? imgDownload;

  static const _borderRadius = 26.0;

  @override
  void initState() {
    if (widget.message.imageUrl != null) {
      imgDownload = storage.downloadImage(widget.message.imageUrl ?? "");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF0d74ba),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.message.content!,
                        style: const TextStyle(
                          color: Colors.white,
                        )),
                    widget.message.imageUrl!.isEmpty ||
                            widget.message.imageUrl == null
                        ? const SizedBox.shrink()
                        : widget.message.content!.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          _OpenImageDialog(widget.message));
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            widget.message.imageUrl!,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          _OpenImageDialog(widget.message));
                                },
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        widget.message.imageUrl!,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                Jiffy(widget.message.sentTo.toLocal()).jm,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _OpenImageDialog extends StatefulWidget {
  const _OpenImageDialog(this.messageEntity);

  final MessageEntity messageEntity;

  @override
  State<StatefulWidget> createState() => _OpenImageDialogState();
}

class _OpenImageDialogState extends State<_OpenImageDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Image.network(
          widget.messageEntity.imageUrl ?? "",
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
