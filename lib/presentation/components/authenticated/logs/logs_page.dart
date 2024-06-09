import 'package:flutter/cupertino.dart';
import 'package:trifecta/presentation/components/authenticated/logs/logs_day_count.dart';
import 'package:trifecta/presentation/components/authenticated/logs/logs_tasks_listview.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Column(
        children: [
          LogsDayCount(),
          LogsTasksListView(),
        ],
      ),
    );
  }
}
