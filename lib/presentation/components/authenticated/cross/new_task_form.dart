import 'package:flutter/material.dart';
import 'package:trifecta/presentation/components/authentication/trifecta_form_text_field.dart';

class NewTaskForm extends StatefulWidget {
  const NewTaskForm({
    super.key,
  });

  @override
  State<NewTaskForm> createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: deviceWidth * .10),
      height: deviceHeight * .10,
      alignment: Alignment.center,
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
            hintText: '//title..',
            obsecureText: false,
          ),
          IconButton(
            onPressed: () {},
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
