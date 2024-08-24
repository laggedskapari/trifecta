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
  final int logAttendance;
  final int totalLogTasks;

  const LogsLog({
    required this.logEndDate,
    required this.logCompletedOn,
    required this.firebaseLogId,
    required this.logId,
    required this.logTitle,
    required this.logCreatedOn,
    required this.logDuration,
    required this.logInitDate,
    required this.totalLogTasks,
    this.successRate = 0,
    this.logAttendance = 0,
    this.isSuccess = false,
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
      logAttendance: logAttendance,
      successRate: successRate,
      logEndDate: logEndDate,
      logCompletedOn: logCompletedOn,
      totalLogTasks: totalLogTasks,
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
      logAttendance: entity.logAttendance,
      totalLogTasks: entity.totalLogTasks,
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
        logAttendance,
        totalLogTasks,
      ];
}
