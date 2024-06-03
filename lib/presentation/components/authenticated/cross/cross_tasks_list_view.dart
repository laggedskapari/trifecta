import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:trifecta/bloc/Cross/TaskBloc/task_bloc.dart';

class CrossTasksListView extends StatelessWidget {
  const CrossTasksListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      height: deviceHeight * .70,
      margin: EdgeInsets.symmetric(horizontal: deviceWidth * .10),
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
            return ListView.builder(
              itemBuilder: (context, index) => Text(
                state.crossTasks[index].taskTitle,
              ),
              itemCount: state.crossTasks.length,
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
