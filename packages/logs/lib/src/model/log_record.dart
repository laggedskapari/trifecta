import 'package:equatable/equatable.dart';
import 'package:log/src/entity/log_record_entity.dart';

class LogRecord extends Equatable {
  final DateTime? logRecordDate;
  final List<dynamic> logRecordTasks;
  final bool? isCompleted;
  final int totalLogTasks;
  final int totalCompletedLogTasks;

  const LogRecord({
    required this.logRecordDate,
    required this.logRecordTasks,
    required this.isCompleted,
    required this.totalLogTasks,
    required this.totalCompletedLogTasks,
  });

  LogRecordEntity toLogRecordEntity() {
    return LogRecordEntity(
      logRecordDate: logRecordDate,
      logRecordTasks: logRecordTasks,
      isCompleted: isCompleted,
      totalLogTasks: totalLogTasks,
      totalCompletedLogTasks: totalCompletedLogTasks,
    );
  }

  static LogRecord fromLogRecordEntity(LogRecordEntity entity) {
    return LogRecord(
      logRecordDate: entity.logRecordDate,
      logRecordTasks: entity.logRecordTasks,
      isCompleted: entity.isCompleted,
      totalLogTasks: entity.totalLogTasks,
      totalCompletedLogTasks: entity.totalCompletedLogTasks,
    );
  }

  @override
  List<Object?> get props => [
        isCompleted,
        logRecordTasks,
        logRecordDate,
        totalLogTasks,
        totalCompletedLogTasks
      ];
}
