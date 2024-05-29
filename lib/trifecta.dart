import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/presentation/color_scheme/trifecta_dark.dart';
import 'package:trifecta/presentation/screens/authentication/authentication_screen.dart';
import 'package:trifecta_authentication/trifecta_authentication_repository.dart';

class Trifecta extends StatelessWidget {
  const Trifecta({
    super.key,
    required this.trifectaAuthenticationRepository,
  });

  final TrifectaAuthenticationRepository trifectaAuthenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
      ],
      child: MaterialApp(
        theme: trifectaDark,
        home: const AuthenticationScreen(),
      ),
    );
  }
}
