import 'package:flutter/material.dart';

class LogsDayCount extends StatelessWidget {
  const LogsDayCount({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
        ),
      ),
      height: deviceHeight * .4,
      child: Text(
        '10',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
