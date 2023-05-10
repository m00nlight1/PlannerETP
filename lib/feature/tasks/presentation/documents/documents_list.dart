import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/app/presentation/components/search_text_field.dart';
import 'package:planner_etp/feature/tasks/domain/document/document_entity.dart';
import 'package:planner_etp/feature/tasks/domain/state/task_cubit.dart';
import 'package:planner_etp/feature/tasks/presentation/documents/document_item.dart';

class DocumentsList extends StatefulWidget {
  const DocumentsList({super.key});

  @override
  State<StatefulWidget> createState() => _DocumentsListState();
}

class _DocumentsListState extends State<DocumentsList> {
  TextEditingController textSearchEditingController = TextEditingController();

  List<DocumentEntity> result = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.docList.isNotEmpty) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 3.0),
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
                          }),
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
                        return DocumentItem(
                            documentEntity: state.docList[index]);
                      },
                    ),
                  ),
              ],
            );
          }
          if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) {
            return const AppLoader();
          }
          return const SizedBox.shrink();
        });
  }
}
