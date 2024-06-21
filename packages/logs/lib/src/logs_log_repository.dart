import 'package:log/src/model/models.dart';

abstract class LogsLogRepository {
  Stream<List<LogsLog>> getAllLogs();
  Future<void> createNewLogsLog({
    required String logTitle,
    required int logDuration,
    required List<LogTask> logTasks,
  });

  Future<void> deleteLogsLog({
    required String firebaseLogId,
  });

  Future<void> updateLogsLog({
    required String logTitle,
    required int logDuration,
    required DateTime logInitDate,
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
}
