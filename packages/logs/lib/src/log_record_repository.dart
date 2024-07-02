import 'package:log/src/model/log_record.dart';

abstract class LogRecordRepository {
  Stream<List<LogRecord>> getAllLogRecords({
    required String firebaseLogId,
  });

  Future<LogRecord> getTodayLogRecord({
    required String firebaseLogId,
  });

  Future<bool> isLogTaskCompletedToday({
    required String firebaseLogId,
  });

  Future<void> createNewLogRecord({
    required String firebaseLogId,
    required String firebaseLogTaskId,
    required String logRecordDate,
  });

  Future<void> deleteLogRecord({
    required String firebaseLogId,
    required String firebaseLogRecordId,
  });
  Future<void> removeTaskFromLogRecord({
    required String firebaseLogId,
    required String firebaseLogRecordId,
    required String firebaseLogTaskId,
  });
}
