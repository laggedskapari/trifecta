import 'package:flutter/material.dart';

class ConfirmDialogBox extends StatelessWidget {
  const ConfirmDialogBox({
    super.key,
    required this.dialogTitle,
    required this.onAffirmative,
    required this.onNegative,
    required this.dialogAction,
  });

  final String dialogAction;
  final String dialogTitle;
  final void Function() onAffirmative;
  final void Function() onNegative;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      margin:  EdgeInsets.symmetric(
        vertical: deviceHeight * .40,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Container(
        height: 80,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '//$dialogAction',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            Text(
              'task -> $dialogTitle',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: ButtonStyle(
                        overlayColor: WidgetStateColor.resolveWith(
                            (states) => Colors.transparent)),
                    onPressed: onAffirmative,
                    child: Text(
                      '[AFFIRMTIVE]',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: WidgetStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '[NEGATIVE]',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
