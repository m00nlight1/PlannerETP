import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:planner_etp/app/domain/error_entity/error_entity.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/app/presentation/components/app_snack_bar.dart';
import 'package:planner_etp/app/presentation/components/search_text_field.dart';
import 'package:planner_etp/feature/tasks/domain/document/document_entity.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';
import 'package:planner_etp/feature/tasks/presentation/documents/document_item.dart';

class DocumentsList extends StatefulWidget {
  const DocumentsList({Key? key}) : super(key: key);

  @override
  DocumentsListState createState() => DocumentsListState();
}

class DocumentsListState extends State<DocumentsList> {
  TextEditingController textSearchEditingController = TextEditingController();

  List<DocumentEntity> result = [];

  @override
  void dispose() {
    textSearchEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state.asyncSnapshot!.hasData && state.asyncSnapshot!.data != true) {
          AppSnackBar.showSnackBarWithMessage(
              context, state.asyncSnapshot!.data.toString());
        }
        if (state.asyncSnapshot!.hasError) {
          AppSnackBar.showSnackBarWithError(
              context, ErrorEntity.fromException(state.asyncSnapshot!.error));
        }
      },
      builder: (context, state) {
        if (state.docList.isNotEmpty) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchTextField(
                      controller: textSearchEditingController,
                      onChange: (value) {
                        if (textSearchEditingController.text.isEmpty) {
                          result = state.docList;
                          context.read<TaskCubit>().fetchDocuments();
                        } else {
                          result = state.docList
                              .where((element) => element.name
                                  .toLowerCase()
                                  .contains(textSearchEditingController.text
                                      .toLowerCase()))
                              .toList();
                          context.read<TaskCubit>().fetchDocuments();
                        }
                      },
                    ),
                  ],
                ),
              ),
              if (textSearchEditingController.text.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return DocumentItem(documentEntity: result[index]);
                    },
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.docList.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        key: UniqueKey(),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                final doc = state.docList[index];
                                context
                                    .read<TaskCubit>()
                                    .deleteDocument(doc.id.toString())
                                    .then((_) {
                                  context.read<TaskCubit>().fetchDocuments();
                                });
                              },
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                            ),
                          ],
                        ),
                        child:
                            DocumentItem(documentEntity: state.docList[index]),
                      );
                    },
                  ),
                ),
            ],
          );
        }
        if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) {
          return const AppLoader();
        }
        return SizedBox(
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
              child: Text(
                "Список документов пуст",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
