import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrifectaNavigationBar extends StatefulWidget {
  const TrifectaNavigationBar({super.key, required this.changeScreen});

  final void Function(int index) changeScreen;

  @override
  State<TrifectaNavigationBar> createState() => _TrifectaNavigationBar();
}

class _TrifectaNavigationBar extends State<TrifectaNavigationBar> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    List<String> screens = ['CROSS', 'LOGS', 'FOCUS'];
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;

    return Container(
      alignment: Alignment.center,
      height: displayHeight * .07,
      margin: EdgeInsets.symmetric(
        horizontal: displayWidth * .05,
      ),
      child: ListView.builder(
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              currentIndex = index;
              widget.changeScreen(index);
              HapticFeedback.lightImpact();
            });
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              screens[index],
              style: TextStyle(
                fontSize: 18,
                fontWeight: index == currentIndex ? FontWeight.w900 : FontWeight.normal,
                color: index == currentIndex ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: screens.length,
      ),
    );
  }
}
