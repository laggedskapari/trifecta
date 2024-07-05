import 'package:flutter/material.dart';

class TrifectaProceedButton extends StatelessWidget {
  const TrifectaProceedButton({
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
        child: const Text(
          '[PROCEED]',
          style: TextStyle(
            color: Colors.green,
            fontSize: 19,
            fontFamily: 'JetBrainsMono',
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
