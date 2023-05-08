import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
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
    return GestureDetector(
      child: GFCard(
        boxFit: BoxFit.cover,
        content: Row(
          children: [
            Text(widget.documentEntity.name),
          ],
        ),
      ),
    );
  }

}