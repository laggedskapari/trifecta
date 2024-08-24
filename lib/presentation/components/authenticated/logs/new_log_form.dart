import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log/logs_repository.dart';
import 'package:trifecta/bloc/Logs/LogsBloc/logs_bloc.dart';
import 'package:trifecta/presentation/components/authenticated/logs/new_log_task_card.dart';
import 'package:trifecta/presentation/components/trifecata_proceed_button.dart';
import 'package:trifecta/presentation/components/trifecta_decline_button.dart';

class NewLogForm extends StatefulWidget {
  const NewLogForm({
    super.key,
    required this.logTitleController,
    required this.logTaskTitleController,
    required this.logDurationController,
    required this.logTasks,
    required this.onProceed,
    required this.onDecline,
  });

  final TextEditingController logTitleController;
  final TextEditingController logTaskTitleController;
  final TextEditingController logDurationController;
  final List<LogTask> logTasks;
  final void Function() onProceed;
  final void Function() onDecline;

  @override
  State<NewLogForm> createState() => _NewLogFormState();
}

class _NewLogFormState extends State<NewLogForm> {
  void onProceed() {
    if (widget.logDurationController.text.trim().isNotEmpty && widget.logTitleController.text.trim().isNotEmpty && widget.logTasks.isNotEmpty) {
      BlocProvider.of<LogsBloc>(context).add(
        CreateNewLogEvent(
          logTitle: widget.logTitleController.text.trim(),
          logTasks: widget.logTasks,
          logDuration: int.parse(widget.logDurationController.text.trim().toString()),
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
    if (widget.logTaskTitleController.text.trim().isNotEmpty) {
      setState(() {
        widget.logTasks.add(
          LogTask(
            logTaskTitle: widget.logTaskTitleController.text.trim(),
            firebaseLogTaskId: '',
          ),
        );
        widget.logTaskTitleController.text = '';
      });
    }
  }

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
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      maxLength: 20,
                      controller: widget.logTitleController,
                      style: Theme.of(context).textTheme.titleMedium,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        counter: const Offstage(),
                        hintText: 'log title...',
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      maxLength: 20,
                      controller: widget.logDurationController,
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
                  ),
                ],
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
                  Text(
                    'Add Tasks that you need to be available daily to be completed in order to increase streak.',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => NewLogTaskCard(
                      logTaskTitle: widget.logTasks[index].logTaskTitle,
                    ),
                    itemCount: widget.logTasks.length,
                  ),
                  TextField(
                    maxLines: 1,
                    maxLength: 20,
                    controller: widget.logTaskTitleController,
                    onSubmitted: (val) {
                      addNewTask();
                    },
                    style: Theme.of(context).textTheme.titleMedium,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 8),
                      counter: const Offstage(),
                      hintText: 'log task title...',
                      hintStyle: Theme.of(context).textTheme.labelMedium,
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TrifectaProceedButton(
                    onTap: widget.onProceed,
                  ),
                  TrifectaDeclineButton(
                    onTap: widget.onDecline,
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
