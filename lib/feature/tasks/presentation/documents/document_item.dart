import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:planner_etp/feature/tasks/domain/document/document_entity.dart';
import 'package:planner_etp/feature/tasks/presentation/pdf_viewer_screen.dart';
import 'package:planner_etp/feature/tasks/domain/firebase_storage_service.dart';

class DocumentItem extends StatefulWidget {
  final DocumentEntity documentEntity;

  const DocumentItem({Key? key, required this.documentEntity})
      : super(key: key);

  @override
  DocumentItemState createState() => DocumentItemState();
}

class DocumentItemState extends State<DocumentItem> {
  String? pathPDF;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting("ru");
    FileImgStorage().createFileOfPdfUrl(widget.documentEntity.filePath).then((path) {
      setState(() {
        pathPDF = path;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        if (pathPDF != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFScreen(path: pathPDF!),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Card(
          child: ListTile(
            title: Text(widget.documentEntity.name,
                maxLines: 2, style: theme.textTheme.headlineSmall),
            subtitle: Row(
              children: [
                Text(
                    DateFormat.yMMMd("ru")
                        .format(widget.documentEntity.createdAt),
                    style: theme.textTheme.bodyMedium),
                const SizedBox(width: 5),
                Text(
                    DateFormat.Hm("ru").format(widget.documentEntity.createdAt),
                    style: theme.textTheme.bodyMedium),
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