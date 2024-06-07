import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCountdownCard extends StatefulWidget {
  const DateCountdownCard({super.key});

  @override
  State<DateCountdownCard> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<DateCountdownCard> {
  late Timer timer;
  late DateTime _endTime;
  double _percentComplete = 0.0;

  @override
  void initState() {
    super.initState();
    _resetTimer();
  }

  void _startTimer() {
    const repeater = Duration(seconds: 1);
    timer = Timer.periodic(repeater, (timer) {
      DateTime now = DateTime.now();
      if (now.isAfter(_endTime)) {
        _resetTimer();
      } else {
        Duration remaining = _endTime.difference(now);
        Duration total =
            _endTime.difference(_endTime.subtract(const Duration(days: 1)));
        setState(() {
          _percentComplete =
              ((total - remaining).inSeconds / total.inSeconds) * 100;
          _percentComplete = double.parse(_percentComplete.toStringAsFixed(6));
        });
      }
    });
  }

  void _resetTimer() {
    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    _endTime = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
    _startTimer();
  }

  String _formatDuration(Duration duration) {
    String hours = (duration.inHours % 24).toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '${hours}h ${minutes}m ${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    Duration timerDuration = _endTime.difference(now);
    String formattedTime = _formatDuration(timerDuration);

    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '//${DateFormat('E MMM d yyyy').format(now).toString().toUpperCase()}',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Text(
            formattedTime,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            '//$_percentComplete % COMPLETED',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
