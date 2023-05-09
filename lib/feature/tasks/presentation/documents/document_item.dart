import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:planner_etp/feature/tasks/domain/document/document_entity.dart';

class DocumentItem extends StatefulWidget {
  final DocumentEntity documentEntity;

  const DocumentItem({super.key, required this.documentEntity});

  @override
  State<StatefulWidget> createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      child: GFCard(
        boxFit: BoxFit.cover,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.documentEntity.name,
                    style: theme.textTheme.headlineSmall),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(DateFormat.yMMMd("ru")
                        .format(widget.documentEntity.createdAt)),
                    const SizedBox(width: 5),
                    Text(DateFormat.Hm("ru")
                        .format(widget.documentEntity.createdAt)),
                  ],
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
