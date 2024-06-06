import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/bloc/Cross/TaskBloc/task_bloc.dart';

class NewTaskForm extends StatefulWidget {
  const NewTaskForm({
    super.key,
    required this.firebaseTaskListId,
  });

  final String firebaseTaskListId;

  @override
  State<NewTaskForm> createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  final _titleController = TextEditingController();

  void submitNewTask() {
    if (_titleController.text.trim().isNotEmpty) {
      context.read<TaskBloc>().add(CreateNewTaskEvent(
          taskTitle: _titleController.text.trim(),
          firebaseTaskListId: widget.firebaseTaskListId));
          HapticFeedback.heavyImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      alignment: Alignment.center,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.double_arrow_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
          Expanded(
            child: Center(
              child: TextField(
                maxLines: 1,
                maxLength: 20,
                controller: _titleController,
                style: Theme.of(context).textTheme.titleMedium,
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
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: submitNewTask,
              icon: Icon(
                Icons.add_task_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
