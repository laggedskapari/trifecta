import 'package:equatable/equatable.dart';
import 'package:log/src/entity/log_record_entity.dart';

class LogRecord extends Equatable {
  final DateTime logRecordDate;
  final List<String> logRecordTasks;

  const LogRecord({
    required this.logRecordDate,
    required this.logRecordTasks,
  });

  LogRecordEntity toLogRecordEntity() {
    return LogRecordEntity(
      logRecordDate: logRecordDate,
      logRecordTasks: logRecordTasks,
    );
  }

  static LogRecord fromLogRecordEntity(LogRecordEntity entity) {
    return LogRecord(
      logRecordDate: entity.logRecordDate,
      logRecordTasks: entity.logRecordTasks,
    );
  }

  @override
  List<Object?> get props => [logRecordTasks, logRecordDate];
}
