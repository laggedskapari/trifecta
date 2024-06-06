import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:trifecta/bloc/Cross/TaskBloc/task_bloc.dart';
import 'package:trifecta/presentation/components/authenticated/cross/new_task_form.dart';
import 'package:trifecta/presentation/components/authenticated/cross/task_card.dart';

class CrossTasksListView extends StatelessWidget {
  const CrossTasksListView({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      height: deviceHeight * .70,
      margin: const EdgeInsets.fromLTRB(5, 15, 5, 0),
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
                    itemBuilder: (context, index) => TaskCard(
                      task: state.crossTasks[index],
                    ),
                    itemCount: state.crossTasks.length,
                  ),
                ),
                NewTaskForm(
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
