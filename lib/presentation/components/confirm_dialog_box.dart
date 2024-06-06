import 'package:flutter/material.dart';

class ConfirmDialogBox extends StatelessWidget {
  const ConfirmDialogBox({
    super.key,
    required this.dialogTitle,
    required this.onAffirmative,
    required this.onNegative,
  });

  final String dialogTitle;
  final void Function() onAffirmative;
  final void Function() onNegative;

  @override
  Widget build(BuildContext context) {
    double displayHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      height: 50,
      margin: EdgeInsets.symmetric(
        vertical: displayHeight * .40,
      ),
      child: Container(
        alignment: Alignment.center,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.red, width: 3)),
        child: Column(
          children: [
            Text(
              dialogTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Row(
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
            )
          ],
        ),
      ),
    );
  }
}

