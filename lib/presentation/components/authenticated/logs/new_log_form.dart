import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log/logs_repository.dart';
import 'package:trifecta/bloc/Logs/LogsBloc/logs_bloc.dart';
import 'package:trifecta/presentation/components/trifecata_proceed_button.dart';
import 'package:trifecta/presentation/components/trifecta_decline_button.dart';

class NewLogForm extends StatefulWidget {
  const NewLogForm({super.key});

  @override
  State<NewLogForm> createState() => _NewLogFormState();
}

class _NewLogFormState extends State<NewLogForm> {
  List<LogTask> logTasks = [];

  void onProceed() {
    if (_logDurationController.text.trim().isNotEmpty &&
        _logTitleController.text.trim().isNotEmpty &&
        logTasks.isNotEmpty) {
      BlocProvider.of<LogsBloc>(context).add(
        CreateNewLogEvent(
          logTitle: _logTitleController.text.trim(),
          logTasks: logTasks,
          logDuration: int.parse(_logDurationController.text.trim().toString()),
        ),
      );
      HapticFeedback.heavyImpact();
      Navigator.pop(context);
    }
  }

  void onDecline() {
    Navigator.pop(context);
  }

  void addNewTask() {
    if (_logTaskTitleController.text.trim().isNotEmpty) {
      logTasks.add(
        LogTask(
          logTaskTitle: _logTaskTitleController.text.trim(),
          firebaseLogTaskId: '',
        ),
      );
      _logTaskTitleController.text = '';
    }
  }

  final _logTitleController = TextEditingController();
  final _logDurationController = TextEditingController();
  final _logTaskTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: deviceHeight * .05,
          horizontal: deviceWidth * .05,
        ),
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Text(
              'CREATE NEW LOG',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextField(
              maxLines: 1,
              maxLength: 20,
              controller: _logTitleController,
              style: Theme.of(context).textTheme.titleMedium,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                counter: const Offstage(),
                hintText: 'log title...',
                hintStyle: Theme.of(context).textTheme.labelMedium,
                border: InputBorder.none,
              ),
            ),
            TextField(
              maxLines: 1,
              maxLength: 20,
              controller: _logDurationController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: Theme.of(context).textTheme.titleMedium,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                counter: const Offstage(),
                hintText: 'log duration...',
                hintStyle: Theme.of(context).textTheme.labelMedium,
                border: InputBorder.none,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '//LOG TASKS',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  'Add Tasks that you need to be available daily to be completed in order to increase streak.',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Text(
                  logTasks[index].logTaskTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                itemCount: logTasks.length,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.double_arrow_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: TextField(
                      maxLines: 1,
                      maxLength: 20,
                      controller: _logTaskTitleController,
                      style: Theme.of(context).textTheme.titleMedium,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 8),
                        counter: const Offstage(),
                        hintText: 'log task title...',
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: addNewTask,
                  icon: Icon(
                    Icons.add_task_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TrifectaProceedButton(
                    onTap: onProceed,
                  ),
                  TrifectaDeclineButton(
                    onTap: onDecline,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
