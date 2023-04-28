import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:planner_etp/feature/tasks/domain/image_storage_service.dart';
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
  final ImgStorage storage = ImgStorage();
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
    return GestureDetector(
      onTap: () {
        if (widget.taskEntity.category?.id == 1) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              DetailObjectLogScreen(id: widget.taskEntity.id.toString(),
                  taskEntity: widget.taskEntity)
          ));
        } if (widget.taskEntity.category?.id == 3) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              DetailSimpleTaskScreen(id: widget.taskEntity.id.toString(),
                  taskEntity: widget.taskEntity)
          ));
        } if (widget.taskEntity.category?.id == 2) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              DetailSupervisionOrderScreen(id: widget.taskEntity.id.toString(),
                  taskEntity: widget.taskEntity)
          ));
        }
      },
      child: GFCard(
        boxFit: BoxFit.cover,
        content: FutureBuilder(
          future: imgDownload,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Создано ${widget.taskEntity.user?.username ?? ""} \n(${widget.taskEntity.user?.email ?? ""})"),
                      Text(
                          "от ${widget.taskEntity.createdAt.toString().split(" ")[0]}"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(widget.taskEntity.title,
                      style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.transparent,
                    height: 30,
                    width: 100,
                    child: widget.taskEntity.status == null
                        ? const SizedBox()
                        : CustomPaint(
                            painter: CurvePainter(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 22, top: 6),
                              child: Text(widget.taskEntity.status?.name ?? "",
                                  style: theme.textTheme.displayMedium),
                            ),
                          ),
                  ),
                  const SizedBox(height: 10),
                  Text(widget.taskEntity.content ?? "",
                      style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 5),
                  Image.network(
                    snapshot.data ?? "",
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Создано ${widget.taskEntity.user?.username ?? ""} \n(${widget.taskEntity.user?.email ?? ""})"),
                      Text(
                          "от ${widget.taskEntity.createdAt.toString().split(" ")[0]}"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(widget.taskEntity.title,
                      style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: widget.taskEntity.status == null
                        ? const SizedBox()
                        : CustomPaint(
                            painter: CurvePainter(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 22, top: 6),
                              child: Text(widget.taskEntity.status?.name ?? "",
                                  style: theme.textTheme.displayMedium),
                            ),
                          ),
                  ),
                  const SizedBox(height: 15),
                  Text(widget.taskEntity.content ?? "",
                      style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 5),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
