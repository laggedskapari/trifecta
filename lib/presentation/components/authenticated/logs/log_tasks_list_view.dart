import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:trifecta/bloc/Logs/LogTaskBloc/log_task_bloc.dart';
import 'package:trifecta/presentation/components/confirm_dialog_box.dart';

class LogTasksListView extends StatelessWidget {
  const LogTasksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 5, 0),
      alignment: Alignment.centerLeft,
      child: BlocBuilder<LogTaskBloc, LogTaskState>(builder: (context, state) {
        if (state.status == LogTaskStatus.processing) {
          return LoadingIndicator(
            indicatorType: Indicator.ballClipRotatePulse,
            colors: [
              Theme.of(context).colorScheme.primary,
            ],
            strokeWidth: 10,
          );
        }
        if (state.status == LogTaskStatus.success) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (val) async {
                      return await showDialog(
                            context: context,
                            builder: (BuildContext context) => ConfirmDialogBox(
                              dialogTitle: state.logTasks[index].logTaskTitle,
                              onAffirmative: () {},
                              onNegative: () {},
                              dialogAction: 'DELETE',
                            ),
                          ) ??
                          false;
                    },
                    background: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete_rounded,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    child: Text(
                      state.logTasks[index].logTaskTitle,
                    ),
                  ),
                  itemCount: state.logTasks.length,
                ),
              ),
            ],
          );
        }
        if (state.status == LogTaskStatus.failure) {
          return Text(
            state.errorMessage!,
            style: Theme.of(context).textTheme.labelSmall,
          );
        }
        return LoadingIndicator(
          indicatorType: Indicator.ballClipRotatePulse,
          colors: [
            Theme.of(context).colorScheme.secondary,
          ],
          strokeWidth: 10,
        );
      }),
    );
  }
}