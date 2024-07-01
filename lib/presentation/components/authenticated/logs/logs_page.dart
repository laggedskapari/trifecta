import 'package:flutter/material.dart';
import 'package:log/logs_repository.dart';
import 'package:trifecta/presentation/components/authenticated/logs/log_info_card.dart';
import 'package:trifecta/presentation/components/authenticated/logs/logs_list_view.dart';
import 'package:trifecta/presentation/components/authenticated/logs/logs_tasks_listview.dart';
import 'package:trifecta/presentation/components/authenticated/logs/new_log_form.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Column(
        children: [
          SizedBox(
            height: 30,
            child: LogsListView(),
          ),
          LogInfoCard(),
          Expanded(
            child: LogsTasksListView(
              logTasks: [],
            ),
          ),
        ],
      ),
    );
  }
}
