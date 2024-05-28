import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trifecta/presentation/components/authentication/trifecta_form_text_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passkeyController = TextEditingController();
  bool _obsecurePasskey = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: deviceHeight * 0.8,
      alignment: Alignment.center,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: deviceWidth * 0.8,
              child: TrifectaFormTextField(
                textEditingController: _emailController,
                hintText: 'email...',
                obsecureText: false,
                textInputType: TextInputType.emailAddress,
                errorMessage: _errorMessage,
                validator: (value) {
                  if (value!.isEmpty) {
                    _errorMessage = '//NO EMAIL FOUND!';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    _errorMessage = '//EMAIL NOT VALID!';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.8,
              child: TrifectaFormTextField(
                textEditingController: _passkeyController,
                hintText: 'passkey...',
                obsecureText: _obsecurePasskey,
                textInputType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obsecurePasskey = !_obsecurePasskey;
                      if (_obsecurePasskey) {
                        iconPassword = CupertinoIcons.eye_fill;
                      } else {
                        iconPassword = CupertinoIcons.eye_slash_fill;
                      }
                    });
                  },
                  icon: Icon(iconPassword),
                ),
              ),
            ),
            SizedBox(
              width: deviceWidth * 0.8,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  '[PROCEED]',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'JetBrainsMono',
                    color: true ? Colors.green : Colors.grey,
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
