import 'package:flutter/material.dart';
import 'package:log/logs_repository.dart';

class NewLogForm extends StatefulWidget {
  const NewLogForm({super.key});

  @override
  State<NewLogForm> createState() => _NewLogFormState();
}

class _NewLogFormState extends State<NewLogForm> {
  List<LogTask> logTasks = [];

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
              controller: _logTitleController,
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.titleMedium,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                counter: const Offstage(),
                hintText: 'log duration...',
                hintStyle: Theme.of(context).textTheme.labelMedium,
                border: InputBorder.none,
              ),
            ),
            Text(
              '//LOG TASKS',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              'This is description for log tasks.',
              style: Theme.of(context).textTheme.labelSmall,
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
                      controller: _logTitleController,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.titleMedium,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 4),
                        counter: const Offstage(),
                        hintText: 'log task title...',
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '[PROCEED]',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '[DECLINE]',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
