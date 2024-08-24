import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:trifecta/bloc/Cross/TaskBloc/task_bloc.dart';
import 'package:trifecta/bloc/Cross/TaskListBloc/tasklist_bloc.dart';

class CrossTaskListTest extends StatefulWidget {
  const CrossTaskListTest({
    super.key,
  });

  @override
  State<CrossTaskListTest> createState() => _CrossTaskListTestState();
}

class _CrossTaskListTestState extends State<CrossTaskListTest> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state.status == TaskStatus.processing) {
          return LoadingIndicator(
            indicatorType: Indicator.ballClipRotatePulse,
            colors: [
              Theme.of(context).colorScheme.secondary,
            ],
            strokeWidth: 5,
          );
        }
        if (state.status == TaskStatus.success) {
          return Column(
            children: [
              Text(state.crossTasks.length.toString()),
              TextButton(
                onPressed: () {
                  BlocProvider.of<TaskBloc>(context).add(
                    const CreateNewTaskEvent(
                      taskTitle: 'Task 2',
                      firebaseTaskListId: 'wSps6Fhp3v5DBqF9eHvZ',
                    ),
                  );
                },
                child: const Text('[ADD TASKLIST]'),
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
        return TextButton(
          onPressed: () {
            BlocProvider.of<TaskBloc>(context).add(
              const CreateNewTaskEvent(
                taskTitle: 'Task One',
                firebaseTaskListId: 'wSps6Fhp3v5DBqF9eHvZ',
              ),
            );
          },
          child: const Text('[ADD TASKLIST]'),
        );
      },
    );
  }
}
