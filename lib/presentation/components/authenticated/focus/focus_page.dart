import 'package:flutter/material.dart';
import 'package:trifecta/presentation/components/authenticated/focus/new_focus_form.dart';

class FocusPage extends StatelessWidget {
  const FocusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const [
          NewFocusForm(),
        ],
      ),
    );
  }
}
