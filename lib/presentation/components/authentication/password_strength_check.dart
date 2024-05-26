import 'package:flutter/material.dart';

class PasskeyStrengthCheck extends StatefulWidget {
  const PasskeyStrengthCheck({
    super.key,
    required this.passkey,
    required this.onStrengthChange,
  });

  final String passkey;
  final Function(bool isStrong) onStrengthChange;

  @override
  State<PasskeyStrengthCheck> createState() => _PasswordStrengthCheck();
}

class _PasswordStrengthCheck extends State<PasskeyStrengthCheck> {
  @override
  void didUpdateWidget(covariant PasskeyStrengthCheck oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.passkey != oldWidget.passkey) {
      final isStrong = _validators.entries.every(
        (entry) => entry.key.hasMatch(widget.passkey),
      );

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => widget.onStrengthChange(isStrong),
      );
    }
  }

  final Map<RegExp, String> _validators = {
    RegExp(r'[A-Z]'): '//One uppercase letter',
    RegExp(r'[!@#\$%^&*(),.?":{}|<>]'): '//One special character',
    RegExp(r'\d'): '//One number',
    RegExp(r'^.{8,32}$'): '//8-32 characters',
  };

  @override
  Widget build(BuildContext context) {
    final hasValue = widget.passkey.isNotEmpty;

    return Container(
      alignment: AlignmentDirectional.topStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _validators.entries.map(
          (entry) {
            final hasMatch = entry.key.hasMatch(widget.passkey);
            final color = hasValue ? (hasMatch ? Colors.green : Colors.red) : null;
            final weight = hasValue ? (hasMatch ? FontWeight.w900 : FontWeight.normal) : null;
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                entry.value.toUpperCase(),
                style: TextStyle(
                  color: color,
                  fontWeight: weight,
                  fontSize: 14
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
