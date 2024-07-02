import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log/logs_repository.dart';
import 'package:trifecta/bloc/Logs/LogRecordBloc/log_record_bloc.dart';

class LogTaskCard extends StatefulWidget {
  const LogTaskCard({
    super.key,
    required this.logTask,
    required this.isCompleted,
  });

  final LogTask logTask;
  final bool isCompleted;

  @override
  State<LogTaskCard> createState() => _LogTaskCardState();
}

class _LogTaskCardState extends State<LogTaskCard> {
  bool isTaskCompleted = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogRecordBloc, LogRecordState>(
        builder: (context, state) {
      if (state.status == LogRecordStatus.success) {
      print(widget.logTask.firebaseLogTaskId);
      print(state.logRecordTasks.contains(widget.logTask.firebaseLogTaskId.toString()));
      print(state.logRecordTasks);
      print(isTaskCompleted);
      isTaskCompleted = state.logRecordTasks.contains(widget.logTask.firebaseLogTaskId);
      }
      return Container(
        alignment: Alignment.centerLeft,
        child: Text(
          '->> ${widget.logTask.logTaskTitle}',
          style: TextStyle(
            color: isTaskCompleted
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
            decoration: isTaskCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationThickness: 5,
            decorationColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
      );
    });
  }
}
