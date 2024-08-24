import 'package:cross/cross_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log/logs_repository.dart';
import 'package:trifecta/bloc/Authentication/SignInBloc/sign_in_bloc.dart';
import 'package:trifecta/bloc/Authentication/TrifectaAuthenticationBloc/trifecta_authentication_bloc.dart';
import 'package:trifecta/bloc/Cross/TaskBloc/task_bloc.dart';
import 'package:trifecta/bloc/Cross/TaskListBloc/tasklist_bloc.dart';
import 'package:trifecta/bloc/Logs/LogRecordBloc/log_record_bloc.dart';
import 'package:trifecta/bloc/Logs/LogTaskBloc/log_task_bloc.dart';
import 'package:trifecta/bloc/Logs/LogsBloc/logs_bloc.dart';
import 'package:trifecta/presentation/color_scheme/trifecta_dark.dart';
import 'package:trifecta/presentation/screens/authenticated/authenticated_screen.dart';
import 'package:trifecta/presentation/screens/authentication/authentication_screen.dart';
import 'package:trifecta_authentication/trifecta_authentication_repository.dart';

class Trifecta extends StatelessWidget {
  const Trifecta({
    super.key,
    required this.trifectaAuthenticationRepository,
    required this.crossTaskListRepository,
    required this.logsLogRepository,
    required this.crossTaskRepository,
    required this.logsTaskRepository,
    required this.logRecordRepository,
  });

  final TrifectaAuthenticationRepository trifectaAuthenticationRepository;
  final CrossTaskListRepository crossTaskListRepository;
  final CrossTaskRepository crossTaskRepository;
  final LogsLogRepository logsLogRepository;
  final LogsTaskRepository logsTaskRepository;
  final LogRecordRepository logRecordRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TrifectaAuthenticationBloc(
            trifectaAuthenticationRepository: trifectaAuthenticationRepository,
          ),
        ),
        RepositoryProvider(
          create: (context) => TaskListBloc(
            crossTaskListRepository: crossTaskListRepository,
          ),
        ),
        RepositoryProvider(
          create: (context) => crossTaskListRepository,
        ),
        RepositoryProvider(
          create: (context) => TaskBloc(
            crossTaskRepository: crossTaskRepository,
          ),
        ),
        RepositoryProvider(
          create: (context) => crossTaskRepository,
        ),
        RepositoryProvider(
          create: (context) => logsLogRepository,
        ),
        RepositoryProvider(
          create: (context) => LogsBloc(
            logsLogRepository: logsLogRepository,
          ),
        ),
        RepositoryProvider(
          create: (context) => logsTaskRepository,
        ),
        RepositoryProvider(
          create: (context) => LogTaskBloc(
            logsTaskRepository: logsTaskRepository,
          ),
        ),
        RepositoryProvider(
          create: (context) => logRecordRepository,
        ),
        RepositoryProvider(
          create: (context) => LogRecordBloc(
            logRecordRepository: logRecordRepository,
          ),
        )
      ],
      child: MaterialApp(
        theme: trifectaDark,
        home: BlocBuilder<TrifectaAuthenticationBloc,
            TrifectaAuthenticationState>(
          builder: (context, state) {
            if (state.status == TrifectaAuthenticationStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<SignInBloc>(
                    create: (context) => SignInBloc(
                      trifectaAuthenticationRepository: context
                          .read<TrifectaAuthenticationBloc>()
                          .trifectaAuthenticationRepository,
                    ),
                  ),
                ],
                child: const AuthenticatedScreen(),
              );
            }
            return const AuthenticationScreen();
          },
        ),
      ),
    );
  }
}
