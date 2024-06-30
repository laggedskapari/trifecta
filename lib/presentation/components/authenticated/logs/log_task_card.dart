import 'package:flutter/material.dart';
import 'package:log/logs_repository.dart';

class LogTaskCard extends StatelessWidget {
  const LogTaskCard({
    super.key,
    required this.logTask,
    required this.isCompleted,
  });

  final LogTask logTask;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        '->> ${logTask.logTaskTitle}',
        style: TextStyle(
          color: isCompleted
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
          decoration:
              isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
          decorationThickness: 5,
          decorationColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
