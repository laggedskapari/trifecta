import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:log/logs_repository.dart';
import 'package:trifecta/bloc/Logs/LogBloc/log_bloc.dart';
import 'package:trifecta/bloc/Logs/LogRecordBloc/log_record_bloc.dart';
import 'package:trifecta/bloc/Logs/LogTaskBloc/log_task_bloc.dart';
import 'package:trifecta/bloc/Logs/LogsBloc/logs_bloc.dart';
import 'package:trifecta/presentation/components/authenticated/logs/new_log_form.dart';

class LogsListView extends StatefulWidget {
  const LogsListView({super.key});

  @override
  State<LogsListView> createState() => _LogsListViewState();
}

class _LogsListViewState extends State<LogsListView> {
  String today = DateTime.now().day.toString() + DateTime.now().month.toString() + DateTime.now().year.toString();

  final logTitleController = TextEditingController();
  final logDurationController = TextEditingController();
  final logTaskTitleController = TextEditingController();
  List<LogTask> logTasks = [];

  int currentLogIndex = -1;
  void changeLogIndex({
    required int logIndex,
  }) {
    currentLogIndex = logIndex;
  }

  void submitNewLog() {
    if (logDurationController.text.trim().isNotEmpty &&
        logTitleController.text.trim().isNotEmpty &&
        logTasks.isNotEmpty) {
      BlocProvider.of<LogsBloc>(context).add(
        CreateNewLogEvent(
          logTitle: logTitleController.text.trim(),
          logTasks: logTasks,
          logDuration: int.parse(logDurationController.text.trim().toString()),
        ),
      );
      HapticFeedback.heavyImpact();
      Navigator.pop(context);
    }
  }

  void deleteLog({
    required String firebaseLogId,
  }) {
    BlocProvider.of<LogsBloc>(context).add(
      DeleteLogEvent(firebaseLogId: firebaseLogId),
    );
    HapticFeedback.vibrate();
  }

  void onDecline() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<LogsBloc, LogsState>(builder: (context, state) {
      if (state.status == LogsStatus.processing) {
        return LoadingIndicator(
          indicatorType: Indicator.ballClipRotatePulse,
          colors: [
            Theme.of(context).colorScheme.secondary,
          ],
        );
      }
      if (state.status == LogsStatus.success) {
        return ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                horizontal: deviceWidth * .005,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.logs.length,
                itemBuilder: (context, index) => InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onLongPress: () {
                    setState(() {
                      deleteLog(
                        firebaseLogId: state.logs[index].firebaseLogId,
                      );
                    });
                  },
                  onTap: () {
                    setState(() {
                      changeLogIndex(logIndex: index);
                      BlocProvider.of<LogTaskBloc>(context).add(
                        LoadLogTasksEvent(
                          firebaseLogId: state.logs[index].firebaseLogId,
                        ),
                      );
                      BlocProvider.of<LogBloc>(context).add(
                        LoadLogEvent(
                          firebaseLogId: state.logs[index].firebaseLogId,
                        ),
                      );
                      BlocProvider.of<LogRecordBloc>(context).add(
                        LoadTodayLogRecord(
                          firebaseLogId: state.logs[index].firebaseLogId,
                        ),
                      );
                      currentLogIndex = index;
                      HapticFeedback.heavyImpact();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      '[${state.logs[index].logTitle.toUpperCase()}]',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: index == currentLogIndex ? FontWeight.w900 : FontWeight.normal,
                        color: index == currentLogIndex ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
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
                  builder: (context) => NewLogForm(
                    logTitleController: logTitleController,
                    logTaskTitleController: logTaskTitleController,
                    logDurationController: logDurationController,
                    logTasks: logTasks,
                    onProceed: submitNewLog,
                    onDecline: onDecline,
                  ),
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
      if (state.status == LogsStatus.failure) {
        return Text(
          state.error!,
          style: Theme.of(context).textTheme.labelSmall,
        );
      }
      return LoadingIndicator(
        indicatorType: Indicator.ballClipRotatePulse,
        colors: [
          Theme.of(context).colorScheme.error,
        ],
        strokeWidth: 10,
      );
    });
  }
}
