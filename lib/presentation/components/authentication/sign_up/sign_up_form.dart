import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trifecta/presentation/components/authentication/password_strength_check.dart';
import 'package:trifecta/presentation/components/authentication/trifecta_form_text_field.dart';
import 'package:trifecta_authentication/trifecta_authentication_repository.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passkeyController = TextEditingController();
  final _confirmPasskeyController = TextEditingController();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool _obsecurePassword = true;
  bool _isPasskeySecure = false;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: deviceHeight * .8,
      alignment: Alignment.center,
      child: Form(
        key: _signUpFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: deviceWidth * .8,
              child: TrifectaFormTextField(
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
                hintText: 'email...',
                obsecureText: false,
                validator: (value) {
                  if (!RegExp(
                          r'^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$')
                      .hasMatch(value!)) {
                    return '//INVALID EMAIL';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.8,
              child: TrifectaFormTextField(
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
                hintText: 'username...',
                obsecureText: false,
                validator: (value) {
                  if (!RegExp(r'^[A-Za-z][A-Za-z0-9_]{7,29}$')
                      .hasMatch(value!)) {
                    return '//INVALID USERNAME';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.8,
              child: TrifectaFormTextField(
                textInputType: TextInputType.visiblePassword,
                textEditingController: _passkeyController,
                hintText: 'passkey...',
                obsecureText: _obsecurePassword,
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.8,
              child: TrifectaFormTextField(
                textInputType: TextInputType.visiblePassword,
                textEditingController: _confirmPasskeyController,
                hintText: 'confirm passkey...',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obsecurePassword = !_obsecurePassword;
                      if (_obsecurePassword) {
                        iconPassword = CupertinoIcons.eye_fill;
                      } else {
                        iconPassword = CupertinoIcons.eye_slash_fill;
                      }
                    });
                  },
                  icon: Icon(iconPassword),
                ),
                obsecureText: _obsecurePassword,
                validator: (value) {
                  if (value != _passkeyController.text) {
                    return '//CONFIRM PASSKEY DO NO MATCH PASSKEY!';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.8,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: AnimatedBuilder(
                  animation: _passkeyController,
                  builder: (context, child) {
                    final passkey = _passkeyController.text;

                    return PasskeyStrengthCheck(
                      onStrengthChange: (bool value) {
                        setState(() {
                          _isPasskeySecure = value;
                        });
                      },
                      passkey: passkey,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.8,
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                onPressed: () {
                  if (_isPasskeySecure && _signUpFormKey.currentState!.validate()) {
                    TrifectaUser newUser = TrifectaUser.emptyTrifectaUser;
                    newUser = newUser.copyWith(
                      username: _usernameController.text,
                      emailAddress: _emailController.text,
                    );
                    HapticFeedback.heavyImpact();
                  }
                },
                child: const Text(
                  '[PROCEED]',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'JetBrainsMono',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
