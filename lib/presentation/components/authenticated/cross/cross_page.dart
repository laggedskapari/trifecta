import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/bloc/Authentication/SignInBloc/sign_in_bloc.dart';
import 'package:trifecta/presentation/components/authenticated/cross/cross_tasklist_list_view.dart';
import 'package:trifecta/presentation/components/authenticated/cross/cross_tasks_list_view.dart';
import 'package:trifecta/presentation/components/authenticated/cross/date_countdown_card.dart';

class CrossPage extends StatelessWidget {
  const CrossPage({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
            child: CrossTaskListListView(),
          ),
          const DateCountdownCard(),
          const Expanded(
            child: CrossTasksListView(),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<SignInBloc>(context).add(
                const SignOutRequired(),
              );
            },
            child: const Text('SIGNOUT'),
          ),
        ],
      ),
    );
  }
}
