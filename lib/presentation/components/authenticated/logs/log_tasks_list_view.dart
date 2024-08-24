import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:trifecta/bloc/Logs/LogRecordBloc/log_record_bloc.dart';
import 'package:trifecta/bloc/Logs/LogTaskBloc/log_task_bloc.dart';
import 'package:trifecta/presentation/components/authenticated/logs/log_task_card.dart';

class LogTasksListView extends StatelessWidget {
  const LogTasksListView({
    super.key,
    required this.firebaseLogId,
    required this.totalLogTasks,
  });

  final String firebaseLogId;
  final int totalLogTasks;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: deviceHeight * .05,
      ),
      alignment: Alignment.centerLeft,
      child: BlocBuilder<LogTaskBloc, LogTaskState>(builder: (context, state) {
        if (state.status == LogTaskStatus.success) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '//TASKS',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      'Completed each of the tasks provided below to increase your streak.',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                    key: UniqueKey(),
                    child: LogTaskCard(
                      firebaseLogId: firebaseLogId,
                      logTask: state.logTasks[index],
                      isCompleted: false,
                      totalLogTasks: totalLogTasks,
                    ),
                  ),
                  itemCount: state.logTasks.length,
                ),
              ),
            ],
          );
        }
        if (state.status == LogTaskStatus.failure) {
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
          strokeWidth: 10,
        );
      }),
    );
  }
}
