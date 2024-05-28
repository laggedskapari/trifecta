import 'package:flutter/material.dart';
import 'package:trifecta/presentation/components/authentication/authentication_navigation_bar.dart';
import 'package:trifecta/presentation/components/authentication/sign_up/sign_up_form.dart';
import 'package:trifecta/presentation/components/authentication/sign_in/sign_in_form.dart';
import 'package:trifecta/presentation/components/trifecta_app_bar.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  int authenticationWidgetScreen = 0;

  void changeAuthenticationWidget(int index) {
    setState(() {
      authenticationWidgetScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TrifectaAppBar(),
      body: <Widget>[
        const SignUpForm(),
        const SignInForm(),
      ][authenticationWidgetScreen],
      bottomNavigationBar: AuthenticationNavigationBar(
        changeAuthenticationScreen: changeAuthenticationWidget,
      ),
    );
  }
}
