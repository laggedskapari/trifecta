import 'package:cross/cross_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/bloc/Cross/TaskBloc/task_bloc.dart';
import 'package:trifecta/presentation/components/confirm_dialog_box.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
  });

  final CrossTask task;

  @override
  Widget build(BuildContext context) {
    void crossTask() {
      BlocProvider.of<TaskBloc>(context).add(
        UpdateTaskCompletionStatusEvent(
          firebaseTaskListId: task.firebaseTaskListId,
          firebaseTaskId: task.firebaseTaskId,
          taskCompletionStatus: !task.isCompleted,
        ),
      );
    }

    void unCrossTask() {
      BlocProvider.of<TaskBloc>(context).add(
        UpdateTaskCompletionStatusEvent(
          firebaseTaskListId: task.firebaseTaskListId,
          firebaseTaskId: task.firebaseTaskId,
          taskCompletionStatus: !task.isCompleted,
        ),
      );
      HapticFeedback.heavyImpact();
      Navigator.pop(context);
    }

    void toggleTaskImportance(bool isImportant) {
      BlocProvider.of<TaskBloc>(context).add(
        UpdateTaskImportanceStatusEvent(
          firebaseTaskListId: task.firebaseTaskListId,
          firebaseTaskId: task.firebaseTaskId,
          taskImportanceStatus: isImportant,
        ),
      );
    }

    double initialOffset = 0.0;
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 3.0,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Icon(
                (task.isCompleted)
                    ? Icons.task_alt_rounded
                    : (task.isImportant)
                        ? Icons.priority_high_rounded
                        : Icons.double_arrow_rounded,
                color: (task.isCompleted)
                    ? Theme.of(context).colorScheme.secondary
                    : (task.isImportant)
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.primary.withOpacity(.9),
                size: 20,
              ),
            ),
            GestureDetector(
              onHorizontalDragStart: (DragStartDetails details) {
                initialOffset = details.globalPosition.dx;
              },
              onHorizontalDragUpdate: (DragUpdateDetails details) {},
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.globalPosition.dx - initialOffset > 100 &&
                    !task.isCompleted) {
                  crossTask();
                  HapticFeedback.heavyImpact();
                }
              },
              onDoubleTap: () {
                if (task.isCompleted) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => ConfirmDialogBox(
                      dialogAction: 'CROSS',
                      dialogTitle: task.taskTitle,
                      onAffirmative: unCrossTask,
                      onNegative: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                }
              },
              onLongPress: () {
                if (!task.isCompleted) {
                  toggleTaskImportance(!task.isImportant);
                  HapticFeedback.vibrate();
                }
              },
              child: Text(
                task.taskTitle,
                style: TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: (task.isCompleted)
                      ? Theme.of(context).colorScheme.secondary
                      : (task.isImportant)
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.9),
                  decoration: (task.isCompleted)
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationThickness: 5,
                  decorationColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
