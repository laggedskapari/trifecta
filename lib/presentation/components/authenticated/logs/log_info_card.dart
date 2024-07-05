import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/bloc/Logs/LogBloc/log_bloc.dart';
import 'package:trifecta/presentation/components/authenticated/logs/log_tasks_list_view.dart';

class LogInfoCard extends StatelessWidget {
  const LogInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<LogBloc, LogState>(
      builder: (context, state) {
        if (state.status == LogStatus.success) {
          return Expanded(
            child: Container(
              width: deviceWidth * .9,
              margin: EdgeInsets.symmetric(
                horizontal: deviceWidth * .05,
                vertical: deviceHeight * .03,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.log!.logTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '//DURATION: ${state.log!.logDuration.toString()}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    '//SUCCESS RATE: ${state.log!.successRate.toString()} %',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    '//INIT DATE: ${state.log!.logInitDate.toString()}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.log!.logAttendance.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 120,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            '//LOG ATTENDANCE (IN DAYS)',
                            style: Theme.of(context).textTheme.labelSmall,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: LogTasksListView(
                      firebaseLogId: state.log!.firebaseLogId,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Text(
          '//SELECT A LOG',
          style: Theme.of(context).textTheme.labelLarge,
        );
      },
    );
  }
}
