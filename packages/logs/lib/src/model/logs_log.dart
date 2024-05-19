import 'package:equatable/equatable.dart';
import 'package:';

class LogsLog extends Equatable {
  final String firebaseLogId;
  final String logId;
  final String logTitle;
  final DateTime logCreatedOn;
  final int logDuration;
  final double successRate;
  final int allowedSkips;
  final int usedSkips;
  final bool isSuccess;

  const LogsLog({
    required this.firebaseLogId,
    required this.logId,
    required this.logTitle,
    required this.logCreatedOn,
    this.usedSkips = 0,
    this.allowedSkips = 0,
    this.isSuccess = false,
    required this.logDuration,
    this.successRate = 0,
  });

  LogsLogEntity toLogsLogEntity() {

  }

  @override 
  List<Object?> get props => [
        firebaseLogId,
        logId,
        logTitle,
        logCreatedOn,
        usedSkips,
        allowedSkips,
        isSuccess,
        logDuration,
        successRate,
      ];
}
