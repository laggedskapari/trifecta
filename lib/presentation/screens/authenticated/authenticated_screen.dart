import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/bloc/Authentication/SignInBloc/sign_in_bloc.dart';
import 'package:trifecta/presentation/components/authenticated/trifecta_navigation_bar.dart';
import 'package:trifecta/presentation/components/trifecta_app_bar.dart';

class AuthenticatedScreen extends StatelessWidget {
  const AuthenticatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void changeScreen(int x) {}

    return Scaffold(
      appBar: const TrifectaAppBar(),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Authenticated',
            ),
            TextButton(
              onPressed: () {
                context.read<SignInBloc>().add(const SignOutRequired());
              },
              child: const Text(
                '[SIGNOUT]',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'JetBrainsMono',
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: TrifectaNavigationBar(changeScreen: changeScreen),
    );
  }
}
