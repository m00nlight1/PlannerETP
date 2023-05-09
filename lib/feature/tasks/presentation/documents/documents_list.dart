import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner_etp/app/di/init_di.dart';
import 'package:planner_etp/app/presentation/app_loader.dart';
import 'package:planner_etp/app/presentation/components/search_text_field.dart';
import 'package:planner_etp/feature/auth/domain/auth_state/auth_cubit.dart';
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

  final userId = locator
      .get<AuthCubit>()
      .state
      .whenOrNull(authorized: (userEntity) => userEntity.id);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.docList.isNotEmpty) {
            final List<DocumentEntity> resultDocList = state.docList.toList();
            obj(doc) => doc.user?.id == userId;
            var currentUserDocList = resultDocList.where(obj).toList();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchTextField(
                          controller: textSearchEditingController,
                          onChange: (value) {
                            if (textSearchEditingController.text.isEmpty) {
                              result = currentUserDocList;
                              context.read<TaskCubit>().fetchDocuments();
                            } else {
                              result = currentUserDocList
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          return DocumentItem(documentEntity: result[index]);
                        },
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: currentUserDocList.length,
                        itemBuilder: (context, index) {
                          return DocumentItem(
                              documentEntity: currentUserDocList[index]);
                        },
                      ),
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
