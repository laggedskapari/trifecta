import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/bloc/Cross/TaskBloc/task_bloc.dart';

class NewTaskCard extends StatefulWidget {
  const NewTaskCard({
    super.key,
    required this.firebaseTaskListId,
  });

  final String firebaseTaskListId;

  @override
  State<NewTaskCard> createState() => _NewTaskCardState();
}

class _NewTaskCardState extends State<NewTaskCard> {
  final _taskTitleController = TextEditingController();

  void submitNewTask() {
    setState(() {
      if (_taskTitleController.text.trim().isNotEmpty) {
        BlocProvider.of<TaskBloc>(context).add(
          CreateNewTaskEvent(
            taskTitle: _taskTitleController.text.trim(),
            firebaseTaskListId: widget.firebaseTaskListId,
          ),
        );
        HapticFeedback.heavyImpact();
        _taskTitleController.text = '';
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
      child: SizedBox(
        height: 15,
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
              onSubmitted: (val) {
                submitNewTask();
              },
              maxLines: 1,
              maxLength: 20,
              controller: _taskTitleController,
              style: Theme.of(context).textTheme.titleLarge,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                counter: const Offstage(),
                hintText: 'title...',
                hintStyle: Theme.of(context).textTheme.labelMedium,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
