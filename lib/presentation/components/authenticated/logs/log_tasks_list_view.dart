import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:trifecta/bloc/Logs/LogRecordBloc/log_record_bloc.dart';
import 'package:trifecta/bloc/Logs/LogTaskBloc/log_task_bloc.dart';
import 'package:trifecta/presentation/components/authenticated/logs/log_task_card.dart';
import 'package:trifecta/presentation/components/confirm_dialog_box.dart';

class LogTasksListView extends StatelessWidget {
  const LogTasksListView({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: deviceWidth * .05,
        vertical: deviceHeight * .05,
      ),
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
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<LogRecordBloc>(context).add(
                          CreateLogRecord(
                            firebaseLogId: 'Pm3VbYgX6t2XW442sS2E',
                            firebaseLogTaskId: state.logTasks[index].firebaseLogTaskId,
                            logRecordDate: "20102024",
                          ),
                        );
                      },
                      child: LogTaskCard(
                        logTask: state.logTasks[index],
                        isCompleted: false,
                      ),
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
