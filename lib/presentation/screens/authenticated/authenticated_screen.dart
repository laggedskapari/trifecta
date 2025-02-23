import 'package:cross/cross_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log/logs_repository.dart';
import 'package:trifecta/bloc/Cross/TaskBloc/task_bloc.dart';
import 'package:trifecta/bloc/Cross/TaskListBloc/tasklist_bloc.dart';
import 'package:trifecta/bloc/Logs/LogBloc/log_bloc.dart';
import 'package:trifecta/bloc/Logs/LogRecordBloc/log_record_bloc.dart';
import 'package:trifecta/bloc/Logs/LogTaskBloc/log_task_bloc.dart';
import 'package:trifecta/bloc/Logs/LogsBloc/logs_bloc.dart';
import 'package:trifecta/presentation/components/authenticated/cross/cross_page.dart';
import 'package:trifecta/presentation/components/authenticated/focus/focus_page.dart';
import 'package:trifecta/presentation/components/authenticated/logs/logs_page.dart';
import 'package:trifecta/presentation/components/authenticated/trifecta_navigation_bar.dart';
import 'package:trifecta/presentation/components/trifecta_app_bar.dart';

class AuthenticatedScreen extends StatefulWidget {
  const AuthenticatedScreen({super.key});

  @override
  State<AuthenticatedScreen> createState() => _AuthenticatedScreenState();
}

class _AuthenticatedScreenState extends State<AuthenticatedScreen> {
  @override
  Widget build(BuildContext context) {
    void changeScreen(int x) {}

    return Scaffold(
      appBar: const TrifectaAppBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TaskListBloc(
                crossTaskListRepository:
                    RepositoryProvider.of<CrossTaskListRepository>(context))
              ..add(LoadTaskListsEvent()),
          ),
          BlocProvider(
            create: (context) => TaskBloc(
                crossTaskRepository:
                    RepositoryProvider.of<CrossTaskRepository>(context)),
          ),
          BlocProvider(
            create: (context) => LogsBloc(
                logsLogRepository:
                    RepositoryProvider.of<LogsLogRepository>(context))
              ..add(LoadLogsEvent()),
          ),
          BlocProvider(
            create: (context) => LogTaskBloc(
                logsTaskRepository:
                    RepositoryProvider.of<LogsTaskRepository>(context)),
          ),
          BlocProvider(
            create: (context) => LogBloc(
                logsLogRepository:
                    RepositoryProvider.of<LogsLogRepository>(context)),
          ),
          BlocProvider(
            create: (context) => LogRecordBloc(
                logRecordRepository:
                    RepositoryProvider.of<LogRecordRepository>(context)),
          ),
        ],
        child: const FocusPage(),
      ),
      bottomNavigationBar: TrifectaNavigationBar(
        changeScreen: changeScreen,
      ),
    );
  }
}
