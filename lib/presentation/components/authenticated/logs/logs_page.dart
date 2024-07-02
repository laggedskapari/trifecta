import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log/logs_repository.dart';
import 'package:trifecta/bloc/Authentication/SignInBloc/sign_in_bloc.dart';
import 'package:trifecta/presentation/components/authenticated/logs/log_info_card.dart';
import 'package:trifecta/presentation/components/authenticated/logs/log_tasks_list_view.dart';
import 'package:trifecta/presentation/components/authenticated/logs/logs_list_view.dart';
import 'package:trifecta/presentation/components/authenticated/logs/new_log_form.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: LogsListView(),
          ),
          LogInfoCard(),
          Expanded(child: LogTasksListView()),
          TextButton(
            onPressed: () {
              BlocProvider.of<SignInBloc>(context).add(
                const SignOutRequired(),
              );
            },
            child: Text('SIGNOUT'),
          ),
        ],
      ),
    );
  }
}
