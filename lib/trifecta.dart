import 'package:flutter/material.dart';
import 'package:trifecta/presentation/color_scheme/trifecta_dark.dart';
import 'package:trifecta/presentation/screens/authentication/authentication_screen.dart';

class Trifecta extends StatelessWidget {
  const Trifecta({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: trifectaDark,
      home: const AuthenticationScreen(),
    );
  }
}
