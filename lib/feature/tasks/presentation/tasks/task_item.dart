import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:planner_etp/feature/tasks/domain/firebase_storage_service.dart';
import 'package:planner_etp/feature/tasks/domain/painter_service.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:planner_etp/feature/tasks/presentation/tasks/category_object_log/detail_object_log_screen.dart';
import 'package:planner_etp/feature/tasks/presentation/tasks/category_simple_task/detail_simple_task_screen.dart';
import 'package:planner_etp/feature/tasks/presentation/tasks/category_supervision_order/detail_supervision_order_screen.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.taskEntity});

  final TaskEntity taskEntity;

  @override
  State<StatefulWidget> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final FileImgStorage storage = FileImgStorage();
  Future<String>? imgDownload;

  @override
  void initState() {
    if (widget.taskEntity.imageUrl != null) {
      imgDownload = storage.downloadImage(widget.taskEntity.imageUrl ?? "");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    initializeDateFormatting("ru");
    return GestureDetector(
      onTap: () {
        if (widget.taskEntity.category?.id == 1) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailObjectLogScreen(
                  id: widget.taskEntity.id.toString(),
                  taskEntity: widget.taskEntity)));
        }
        if (widget.taskEntity.category?.id == 3) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailSimpleTaskScreen(
                  id: widget.taskEntity.id.toString(),
                  taskEntity: widget.taskEntity)));
        }
        if (widget.taskEntity.category?.id == 2) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailSupervisionOrderScreen(
                  id: widget.taskEntity.id.toString(),
                  taskEntity: widget.taskEntity)));
        }
      },
      child: GFCard(
        boxFit: BoxFit.cover,
        content: widget.taskEntity.imageUrl == null ||
                widget.taskEntity.imageUrl!.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Создано ${widget.taskEntity.user?.username ?? ""} \n(${widget.taskEntity.user?.email ?? ""})"),
                      Text(DateFormat.yMMMd("ru")
                          .format(widget.taskEntity.createdAt))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(widget.taskEntity.title,
                      style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 10),
                  widget.taskEntity.status == null
                      ? const SizedBox.shrink()
                      : CustomPaint(
                          painter: CurvePainter(),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 22, top: 6),
                            child: Text(widget.taskEntity.status?.name ?? "",
                                style: theme.textTheme.displayMedium),
                          ),
                        ),
                  const SizedBox(height: 10),
                  Text(widget.taskEntity.content ?? "",
                      style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 5),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Создано ${widget.taskEntity.user?.username ?? ""} \n(${widget.taskEntity.user?.email ?? ""})"),
                      Text(DateFormat.yMMMd("ru")
                          .format(widget.taskEntity.createdAt)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(widget.taskEntity.title,
                      style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 10),
                  widget.taskEntity.status == null
                      ? const SizedBox.shrink()
                      : CustomPaint(
                          painter: CurvePainter(),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 22, top: 6),
                            child: Text(widget.taskEntity.status?.name ?? "",
                                style: theme.textTheme.displayMedium),
                          ),
                        ),
                  const SizedBox(height: 10),
                  Text(widget.taskEntity.content ?? "",
                      style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 5),
                  Image.network(
                    widget.taskEntity.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
      ),
    );
  }
}
