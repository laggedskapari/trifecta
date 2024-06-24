import 'package:flutter/material.dart';
import 'package:log/logs_repository.dart';

class LogInfoCard extends StatelessWidget {
  const LogInfoCard({
    super.key,
    required this.log,
  });

  final LogsLog log;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: deviceWidth * .9,
      height: deviceHeight * .3,
      margin: EdgeInsets.symmetric(horizontal: deviceWidth * .05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            log.logTitle!,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            '//DURATION: ${log.logDuration.toString()}',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            '//SUCCESS RATE: ${log.successRate.toString()} %',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            '//INIT DATE: ${log.logInitDate.toString()}',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  log.logAttendance.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 100,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '//LOG ATTENDANCE (IN DAYS)',
                  style: Theme.of(context).textTheme.labelSmall,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
