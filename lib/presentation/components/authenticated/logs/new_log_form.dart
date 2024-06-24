import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log/logs_repository.dart';
import 'package:trifecta/bloc/Logs/LogsBloc/logs_bloc.dart';

class NewLogForm extends StatefulWidget {
  const NewLogForm({super.key});

  @override
  State<NewLogForm> createState() => _NewLogFormState();
}

class _NewLogFormState extends State<NewLogForm> {
  List<LogTask> logTasks = [];

  void addLogTask() {
    setState(() {
      LogTask newLogTask = LogTask(
        logTaskTitle: _logTaskTitleController.text.trim(),
        firebaseLogTaskId: '',
      );
      logTasks.add(newLogTask);
    });
  }

  void submitNewLog() {
    BlocProvider.of<LogsBloc>(context).add(CreateNewLogEvent(logTitle: 'BE BETTER', logTasks: logTasks, logDuration: 10));
  }

  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _logTaskTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Material(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: deviceWidth * .05,
          vertical: deviceHeight * .05
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              'CREATE NEW LOG',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextField(
              controller: _titleController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                counter: const Offstage(),
                hintText: 'title...',
                hintStyle: Theme.of(context).textTheme.labelLarge,
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                counter: const Offstage(),
                hintText: 'duration...',
                hintStyle: Theme.of(context).textTheme.labelLarge,
                border: InputBorder.none,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '//LOG TASKS',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'These tasks will be available daily. In order to extend your streak completed these tasks every day.',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Text(
                  '-> ${logTasks[index].logTaskTitle}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                itemCount: logTasks.length,
              ),
            ),
            SizedBox(
              height: 49,
              child: Row(
                children: [
                  Icon(
                    size: 20,
                    Icons.double_arrow_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: TextField(
                        controller: _logTaskTitleController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          counter: const Offstage(),
                          hintText: 'task title...',
                          hintStyle: Theme.of(context).textTheme.labelMedium,
                          border: InputBorder.none,
                        ),
                        maxLines: 1,
                        maxLength: 20,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: addLogTask,
                    icon: const Icon(
                      Icons.check_rounded,
                      size: 20,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: submitNewLog,
                  child: Text(
                    '[PROCEED]',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '[DECLINE]',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
