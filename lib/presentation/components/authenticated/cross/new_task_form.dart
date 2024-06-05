import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/bloc/Cross/TaskBloc/task_bloc.dart';
import 'package:trifecta/presentation/components/authentication/trifecta_form_text_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      alignment: Alignment.center,
      child: Row(
        children: [
          Icon(
            Icons.double_arrow_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
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
          IconButton(
            onPressed: () {
              context.read<TaskBloc>().add(
                    CreateNewTaskEvent(
                      taskTitle: _titleController.text.trim(),
                      firebaseTaskListId: widget.firebaseTaskListId,
                    ),
                  );
            },
            icon: Icon(
              Icons.check_rounded,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
