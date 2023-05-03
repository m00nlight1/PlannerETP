import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:jiffy/jiffy.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:planner_etp/feature/tasks/domain/chat/message_entity.dart';
import 'package:planner_etp/feature/tasks/domain/image_storage_service.dart';

class MessageItem extends StatefulWidget {
  final MessageEntity messageEntity;

  const MessageItem({super.key, required this.messageEntity});

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
        // return Align(
        //   alignment: messageEntity.user?.id == userEntity?.id
        //       ? Alignment.centerRight
        //       : Alignment.centerLeft,
        //   child: Card(
        //     elevation: 8,
        //     color: Colors.white,
        //     child: Column(children: [
        //       Text(messageEntity.content),
        //       Text(messageEntity.user?.email ?? ""),
        //     ]),
        //   ),
        // );
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
  final ImgStorage storage = ImgStorage();
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
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.message.user?.username}"),
                    const SizedBox(height: 7),
                    Text(
                      widget.message.content!,
                      style: const TextStyle(color: Colors.black),
                    ),
                    widget.message.imageUrl == ""
                        ? const SizedBox.shrink()
                        : GFCard(
                            boxFit: BoxFit.cover,
                            color: Colors.grey.shade200,
                            margin: EdgeInsets.zero,
                            content: FutureBuilder(
                              future: imgDownload,
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Image.network(
                                        snapshot.data ?? "",
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ),
                  ],
                ),
                // child: Text(message.content ?? ''),
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
  final ImgStorage storage = ImgStorage();
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
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(widget.message.content!,
                        style: const TextStyle(
                          color: Colors.white,
                        )),
                    widget.message.imageUrl == ""
                        ? const SizedBox.shrink()
                        : const SizedBox(height: 5),
                    FutureBuilder(
                              future: imgDownload,
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  return Image.network(
                                    snapshot.data ?? "",
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.2,
                                    width:
                                    MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
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
