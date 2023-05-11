import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:planner_etp/feature/tasks/domain/document/document_entity.dart';
import 'package:planner_etp/feature/tasks/domain/file_pdf_service.dart';

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
    initializeDateFormatting("ru");
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PDFScreen(path: widget.documentEntity.filePath)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Card(
          child: ListTile(
            title: Text(widget.documentEntity.name,
                style: theme.textTheme.headlineSmall),
            subtitle: Row(
              children: [
                Text(DateFormat.yMMMd("ru")
                    .format(widget.documentEntity.createdAt), style: theme.textTheme.bodyMedium),
                const SizedBox(width: 5),
                Text(DateFormat.Hm("ru")
                    .format(widget.documentEntity.createdAt), style: theme.textTheme.bodyMedium),
              ],
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
