import 'package:log/src/model/models.dart';

abstract class LogsTaskRepository {
  Stream<List<LogTask>> getAllLogTasks({
    required String firebaseLogId,
  });

  Future<void> createNewLogTasks({
    required String firebaseLogId,
    required List<LogTask> logTasks,
  });

  Future<void> deleteLogTask({
    required String firebaseLogId,
    required String firebaseLogTaskId,
  });
}
