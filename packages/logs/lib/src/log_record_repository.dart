import 'package:log/src/model/log_record.dart';

abstract class LogRecordRepository {
  Stream<List<LogRecord>> getAllLogRecords({
    required String firebaseLogId,
  });

  Future<LogRecord> getTodayLogRecord({
    required String firebaseLogId,
  });

  Future<void> createNewLogRecord({
    required String firebaseLogId,
    required String firebaseLogTaskId,
    required int totalLogTasks,
  });

  Future<void> deleteLogRecord({
    required String firebaseLogId,
    required String firebaseLogRecordId,
  });

  Future<void> removeTaskFromLogRecord({
    required String firebaseLogId,
    required String firebaseLogTaskId,
  });
}
