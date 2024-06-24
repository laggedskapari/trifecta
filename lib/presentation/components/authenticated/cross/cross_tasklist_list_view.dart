import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:trifecta/bloc/Cross/TaskBloc/task_bloc.dart';
import 'package:trifecta/bloc/Cross/TaskListBloc/tasklist_bloc.dart';
import 'package:trifecta/presentation/components/authenticated/cross/new_tasklist_form.dart';

class CrossTaskListListView extends StatefulWidget {
  const CrossTaskListListView({
    super.key,
  });

  @override
  State<CrossTaskListListView> createState() => _CrossTaskListListViewState();
}

class _CrossTaskListListViewState extends State<CrossTaskListListView> {
  int currentTaskListIndex = -1;
  void changeTaskList({required int taskListIndex}) {
    taskListIndex = currentTaskListIndex;
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

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
          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                height: deviceHeight * .10,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: deviceWidth * .01,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.crossTaskLists.length,
                  itemBuilder: (context, index) => InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        changeTaskList(taskListIndex: index);
                        BlocProvider.of<TaskBloc>(context).add(
                          LoadTasksEvent(
                            firebaseTaskListId:
                                state.crossTaskLists[index].firebaseTaskListId,
                          ),
                        );
                        currentTaskListIndex = index;
                        HapticFeedback.heavyImpact();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
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
                ),
              ),
              InkWell(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) => const NewTaskListForm(),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    '[+]',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        if (state.status == TaskListStatus.failure) {
          print('Error');
          return Text(
            state.errorMessage!,
            style: Theme.of(context).textTheme.labelSmall,
          );
        }
        return LoadingIndicator(
          indicatorType: Indicator.ballClipRotatePulse,
          colors: [
            Theme.of(context).colorScheme.primary,
          ],
          strokeWidth: 10,
        );
      },
    );
  }
}
