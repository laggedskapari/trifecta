import 'package:equatable/equatable.dart';
import 'package:log/src/entity/entities.dart';

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
  final bool isStrict;
  final DateTime logEndDate;
  final DateTime logCompletedOn;
  final DateTime logInitDate;

  const LogsLog({
    required this.isStrict,
    required this.logEndDate,
    required this.logCompletedOn,
    required this.firebaseLogId,
    required this.logId,
    required this.logTitle,
    required this.logCreatedOn,
    this.usedSkips = 0,
    this.allowedSkips = 0,
    this.isSuccess = false,
    required this.logDuration,
    this.successRate = 0,
    required this.logInitDate,
  });

  LogsLogEntity toLogsLogEntity() {
    return LogsLogEntity(
      logInitDate: logInitDate,
      firebaseLogId: firebaseLogId,
      logId: logId,
      logTitle: logTitle,
      logCreatedOn: logCreatedOn,
      usedSkips: usedSkips,
      isSuccess: isSuccess,
      logDuration: logDuration,
      successRate: successRate,
      allowedSkips: allowedSkips,
      isStrict: isStrict,
      logEndDate: logEndDate,
      logCompletedOn: logCompletedOn,
    );
  }

  static LogsLog fromLogsLogEntity(LogsLogEntity entity) {
    return LogsLog(
      logInitDate: entity.logInitDate,
      firebaseLogId: entity.firebaseLogId,
      logId: entity.logId,
      logTitle: entity.logTitle,
      logDuration: entity.logDuration,
      logCreatedOn: entity.logCreatedOn,
      successRate: entity.successRate,
      isSuccess: entity.isSuccess,
      allowedSkips: entity.allowedSkips,
      usedSkips: entity.usedSkips,
      isStrict: entity.isStrict,
      logCompletedOn: entity.logCompletedOn,
      logEndDate: entity.logEndDate,
    );
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
        isStrict,
        logEndDate,
        logCompletedOn,
        logInitDate,
      ];
}
