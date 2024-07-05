import 'package:flutter/material.dart';

class TrifectaDeclineButton extends StatelessWidget {
  const TrifectaDeclineButton({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: onTap,
        style: const ButtonStyle(
          splashFactory: NoSplash.splashFactory,
        ),
        child: Text(
          '[DECLINE]',
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontSize: 19,
            fontFamily: 'JetBrainsMono',
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
