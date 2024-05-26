import 'package:flutter/material.dart';

class AuthenticationNavigationBar extends StatefulWidget {
  const AuthenticationNavigationBar(
      {super.key, required this.changeAuthenticationScreen});

  final void Function(int index) changeAuthenticationScreen;

  @override
  State<AuthenticationNavigationBar> createState() =>
      _AuthenticationNavigationBarState();
}

class _AuthenticationNavigationBarState
    extends State<AuthenticationNavigationBar> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {

    List<String> authenticationScreen = ['SIGNUP', 'SIGNIN'];
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;

    return Container(
      alignment: Alignment.center,
      height: displayHeight * .10,
      width: displayWidth * .05,
      child: ListView.builder(
        itemBuilder: (context, index) => InkWell(
          onTap: () {},
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Text(
            authenticationScreen[index],
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  index == currentIndex ? FontWeight.w900 : FontWeight.normal,
              color: index == currentIndex
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        itemCount: authenticationScreen.length,
        shrinkWrap: true,
      ),
    );
  }
}