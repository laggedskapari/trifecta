import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log/logs_repository.dart';
import 'package:trifecta/bloc/Logs/LogBloc/log_bloc.dart';
import 'package:trifecta/bloc/Logs/LogRecordBloc/log_record_bloc.dart';
import 'package:trifecta/bloc/Logs/LogsBloc/logs_bloc.dart';
import 'package:trifecta/presentation/components/confirm_dialog_box.dart';

class LogTaskCard extends StatefulWidget {
  const LogTaskCard({
    super.key,
    required this.logTask,
    required this.isCompleted,
    required this.firebaseLogId,
    required this.totalLogTasks,
  });

  final LogTask logTask;
  final bool isCompleted;
  final String firebaseLogId;
  final int totalLogTasks;

  @override
  State<LogTaskCard> createState() => _LogTaskCardState();
}

class _LogTaskCardState extends State<LogTaskCard> {
  bool isTaskCompleted = false;
  double initialOffset = 0.0;

  void completeLogTask({required int totalCompletedTasks}) {
    setState(() {
      BlocProvider.of<LogRecordBloc>(context).add(
        CreateLogRecord(
          firebaseLogId: widget.firebaseLogId,
          firebaseLogTaskId: widget.logTask.firebaseLogTaskId,
          totalLogTasks: widget.totalLogTasks,
        ),
      );
      if (totalCompletedTasks == widget.totalLogTasks - 1) {
        BlocProvider.of<LogsBloc>(context).add(
          IncreaseLogAttendanceEvent(
            firebaseLogId: widget.firebaseLogId,
          ),
        );
        BlocProvider.of<LogBloc>(context).add(
          LoadLogEvent(
            firebaseLogId: widget.firebaseLogId,
          ),
        );
      }
    });
  }

  void uncompleteLogTask({required int totalCompletedTasks}) {
    BlocProvider.of<LogRecordBloc>(context).add(
      RemoveTaskFromLogRecord(
        firebaseLogId: widget.firebaseLogId,
        firebaseLogTaskId: widget.logTask.firebaseLogTaskId,
      ),
    );
    if (widget.totalLogTasks == totalCompletedTasks) {
      BlocProvider.of<LogsBloc>(context).add(
        DecreaseLogAttendanceEvent(
          firebaseLogId: widget.firebaseLogId,
        ),
      );
      BlocProvider.of<LogBloc>(context).add(
        LoadLogEvent(
          firebaseLogId: widget.firebaseLogId,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogRecordBloc, LogRecordState>(
        builder: (context, state) {
      if (state.status == LogRecordStatus.success) {
        isTaskCompleted =
            state.logRecordTasks.contains(widget.logTask.firebaseLogTaskId);
      }
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(
              (isTaskCompleted) ? '[X]' : '[ ]',
              style: TextStyle(
                color: isTaskCompleted
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary,
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
            GestureDetector(
              onHorizontalDragStart: (DragStartDetails details) {
                initialOffset = details.globalPosition.dx;
              },
              onHorizontalDragUpdate: (DragUpdateDetails details) {},
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.globalPosition.dx - initialOffset > 100 && !isTaskCompleted) {
                  completeLogTask(
                    totalCompletedTasks: state.logRecordTasks.length,
                  );
                  HapticFeedback.heavyImpact();
                }
              },
              onDoubleTap: () {
                if (isTaskCompleted) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => ConfirmDialogBox(
                      dialogAction: 'CROSS',
                      dialogTitle: widget.logTask.logTaskTitle,
                      onAffirmative: () {
                        uncompleteLogTask(
                          totalCompletedTasks: state.logRecordTasks.length,
                        );
                      },
                      onNegative: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  widget.logTask.logTaskTitle,
                  style: TextStyle(
                    color: isTaskCompleted
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    decoration: isTaskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 5,
                    decorationColor: Theme.of(context).colorScheme.secondary,
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
