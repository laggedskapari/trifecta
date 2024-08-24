import 'package:flutter/material.dart';

class NewLogTaskCard extends StatelessWidget {
  const NewLogTaskCard({
    super.key,
    required this.logTaskTitle,
  });

  final String logTaskTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(
            Icons.double_arrow_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          Text(
            logTaskTitle,
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
