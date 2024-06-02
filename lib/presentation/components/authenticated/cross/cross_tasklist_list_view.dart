import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:trifecta/bloc/Cross/TaskListBloc/tasklist_bloc.dart';

class CrossTasklistListView extends StatefulWidget {
  const CrossTasklistListView({super.key});

  @override
  State<CrossTasklistListView> createState() => _CrossTasklistListViewState();
}

class _CrossTasklistListViewState extends State<CrossTasklistListView> {
  int currentTaskListIndex = -1;
  void changeTaskList({required int taskListIndex}) {
    taskListIndex = currentTaskListIndex;
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<TaskListBloc, TaskListState>(
      builder: (context, state) {
        if (state.status == TaskListStatus.processing) {
          return LoadingIndicator(
            indicatorType: Indicator.ballClipRotatePulse,
            colors: [
              Theme.of(context).colorScheme.secondary,
            ],
            strokeWidth: 5,
          );
        }
        if (state.status == TaskListStatus.success) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: displayWidth * .10),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    changeTaskList(taskListIndex: index);
                    currentTaskListIndex = index;
                    HapticFeedback.heavyImpact();
                  });
                },
                child: Text(
                  '[${state.crossTaskLists[index].taskListTitle.toUpperCase()}]',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: index == currentTaskListIndex
                        ? FontWeight.w900
                        : FontWeight.normal,
                    color: index == currentTaskListIndex
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          );
        }
        if (state.status == TaskListStatus.failure) {
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
          strokeWidth: 5,
        );
      },
    );
  }
}
