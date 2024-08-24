import 'package:flutter/material.dart';
import 'package:trifecta/presentation/components/authentication/trifecta_form_text_field.dart';

class NewTaskListForm extends StatefulWidget {
  const NewTaskListForm({
    super.key,
    required this.onProceed,
    required this.onDecline,
    required this.taskListTitleController,
  });

  final void Function() onProceed;
  final void Function() onDecline;
  final TextEditingController taskListTitleController;

  @override
  State<NewTaskListForm> createState() => _NewTaskListFormState();
}

class _NewTaskListFormState extends State<NewTaskListForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 130,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              'CREATE NEW TASKLIST',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
              child: TrifectaFormTextField(
                textInputType: TextInputType.text,
                textEditingController: widget.taskListTitleController,
                hintText: '//Title...',
                obsecureText: false,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: widget.onProceed,
                child: const Text(
                  '[PROCEED]',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.green,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: widget.onDecline,
                child: Text(
                  '[DECLINE]',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
