import 'package:flutter/cupertino.dart';

class LogsTasksListView extends StatelessWidget {
  const LogsTasksListView({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: deviceHeight * .4,
      child: Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) => const Text(
            'Task 1',
          ),
          itemCount: 1,
        ),
      ),
    );
  }
}
