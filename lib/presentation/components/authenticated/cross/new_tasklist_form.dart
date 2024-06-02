import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/bloc/Cross/TaskListBloc/tasklist_bloc.dart';
import 'package:trifecta/presentation/components/authentication/trifecta_form_text_field.dart';

class NewTaskListForm extends StatefulWidget {
  const NewTaskListForm({super.key});

  @override
  State<NewTaskListForm> createState() => _NewTaskListFormState();
}

class _NewTaskListFormState extends State<NewTaskListForm> {
  final _titleController = TextEditingController();

  void submitNewTaskList() {
    if (_titleController.text.trim().isNotEmpty) {
      context.read<TaskListBloc>().add(CreateNewTaskListEvent(
            taskListTitle: _titleController.text.trim(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center,
      height: deviceHeight * .10,
      width: deviceWidth * .8,
      child: Row(
        children: [
          Icon(
            Icons.double_arrow_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          TrifectaFormTextField(
            textInputType: TextInputType.text,
            textEditingController: _titleController,
            hintText: '//Title...',
            obsecureText: false,
          ),
          IconButton(
            onPressed: submitNewTaskList,
            icon: Icon(
              Icons.check_rounded,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
