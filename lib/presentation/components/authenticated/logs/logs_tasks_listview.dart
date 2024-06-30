import 'package:flutter/cupertino.dart';
import 'package:log/logs_repository.dart';
import 'package:trifecta/presentation/components/authenticated/logs/log_task_card.dart';

class LogsTasksListView extends StatelessWidget {
  const LogsTasksListView({
    super.key,
    required this.logTasks,
  });

  final List<LogTask> logTasks;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: deviceHeight * .05,
        horizontal: deviceWidth * .05,
      ),
      child: ListView.builder(
        itemBuilder: (context, index) => const LogTaskCard(
            logTask: LogTask(logTaskTitle: 'TaskOne', firebaseLogTaskId: ''),
            isCompleted: false),
        itemCount: 1,
      ),
    );
  }
}
