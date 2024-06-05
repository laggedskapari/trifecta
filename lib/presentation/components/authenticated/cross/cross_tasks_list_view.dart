import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:trifecta/bloc/Cross/TaskBloc/task_bloc.dart';
import 'package:trifecta/presentation/components/authenticated/cross/new_task_form.dart';

class CrossTasksListView extends StatelessWidget {
  const CrossTasksListView({
    super.key,
    required this.firebaseTaskListId,
  });

  final String firebaseTaskListId;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      height: deviceHeight * .70,
      margin: EdgeInsets.symmetric(
        horizontal: deviceWidth * .05,
      ),
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
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => Text(
                      state.crossTasks[index].taskTitle,
                    ),
                    itemCount: state.crossTasks.length,
                  ),
                ),
                NewTaskForm(
                  firebaseTaskListId: firebaseTaskListId,
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
