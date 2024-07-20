import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:trifecta/bloc/Cross/TaskBloc/task_bloc.dart';
import 'package:trifecta/presentation/components/authenticated/cross/new_task_card.dart';
import 'package:trifecta/presentation/components/authenticated/cross/task_card.dart';
import 'package:trifecta/presentation/components/confirm_dialog_box.dart';

class CrossTasksListView extends StatelessWidget {
  const CrossTasksListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void deleteTask(
      String firebaseTaskId,
      String firebaseTaskListId,
    ) {
      BlocProvider.of<TaskBloc>(context).add(
        DeleteTaskEvent(
          firebaseTaskListId: firebaseTaskListId,
          firebaseTaskId: firebaseTaskId,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 5, 0),
      alignment: Alignment.centerLeft,
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state.status == TaskStatus.processing) {
            return LoadingIndicator(
              indicatorType: Indicator.ballClipRotatePulse,
              strokeWidth: 5,
              colors: [
                Theme.of(context).colorScheme.primary,
              ],
            );
          }
          if (state.status == TaskStatus.success) {
            return ListView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (val) async {
                      return await showDialog(
                            context: context,
                            builder: (BuildContext context) => ConfirmDialogBox(
                              dialogAction: 'DELETE',
                              dialogTitle: state.crossTasks[index].taskTitle,
                              onAffirmative: () {
                                deleteTask(
                                  state.crossTasks[index].firebaseTaskId,
                                  state.firebaseTaskListId,
                                );
                              },
                              onNegative: () {
                                Navigator.pop(context, false);
                              },
                            ),
                          ) ??
                          false;
                    },
                    background: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete_rounded,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    child: TaskCard(
                      task: state.crossTasks[index],
                    ),
                  ),
                  itemCount: state.crossTasks.length,
                ),
                NewTaskCard(
                  firebaseTaskListId: state.firebaseTaskListId,
                ),
              ],
            );
          }
          if (state.status == TaskStatus.failure) {
            return Text(
              state.errorMessage!,
              style: Theme.of(context).textTheme.labelSmall,
            );
          }
          return LoadingIndicator(
            indicatorType: Indicator.ballClipRotatePulse,
            strokeWidth: 5,
            colors: [
              Theme.of(context).colorScheme.primary,
            ],
          );
        },
      ),
    );
  }
}
