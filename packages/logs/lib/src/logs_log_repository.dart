import 'package:log/src/model/models.dart';

abstract class LogsLogRepository {
  Stream<List<LogsLog>> getAllLogs();

  Future<LogsLog> getLog({
    required String firebaseLogId,
  });

  Future<void> createNewLogsLog({
    required String logTitle,
    required int logDuration,
    required List<LogTask> logTasks,
  });

  Future<void> deleteLogsLog({
    required String firebaseLogId,
  });

  Future<void> updateLogsLogSuccess({
    required String firebaseLogId,
    required bool isSuccess,
  });

  Future<void> updateSuccessRate({
    required String firebaseLogId,
    required double successRate,
  });

  Future<void> increaseLogAttendance({
    required String firebaseLogId,
  });

  Future<void> decreaseLogAttendance({
    required String firebaseLogId,
  });
}
