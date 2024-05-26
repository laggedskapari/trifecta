import 'package:flutter/material.dart';

class TrifectaFormTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool obsecureText;
  final TextInputType textInputType;
  final String hintText;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMessage;
  
  final String? Function(String?)? onChanged;

  const TrifectaFormTextField({
    super.key,
    required this.textInputType,
    required this.textEditingController,
    required this.hintText,
    this.onTap,
    this.focusNode,
    required this.obsecureText,
    this.errorMessage,
    this.onChanged,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: textEditingController,
      obscureText: obsecureText,
      keyboardType: textInputType,
      focusNode: focusNode,
      onTap: onTap,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          hintText: hintText,
          errorText: errorMessage,
          errorStyle: const TextStyle(
            color: Colors.red,
            fontFamily: 'JetBrainsMono',
            fontSize: 12.0,
            fontWeight: FontWeight.w900,
          )),
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
