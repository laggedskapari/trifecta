import 'package:equatable/equatable.dart';
import 'package:log/src/entity/entities.dart';

class LogsLog extends Equatable {
  final String firebaseLogId;
  final String logId;
  final String logTitle;
  final DateTime logCreatedOn;
  final int logDuration;
  final double successRate;
  final bool isSuccess;
  final DateTime logEndDate;
  final DateTime logCompletedOn;
  final DateTime logInitDate;

  const LogsLog({
    required this.logEndDate,
    required this.logCompletedOn,
    required this.firebaseLogId,
    required this.logId,
    required this.logTitle,
    required this.logCreatedOn,
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
      isSuccess: isSuccess,
      logDuration: logDuration,
      successRate: successRate,
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
        isSuccess,
        logDuration,
        successRate,
        logEndDate,
        logCompletedOn,
        logInitDate,
      ];
}
