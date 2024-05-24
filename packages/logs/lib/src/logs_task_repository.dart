import 'package:log/src/model/models.dart';

abstract class LogsTaskRepository {
  Stream<List<LogTask>> getAllLogTasks({
    required String firebaseLogId,
  });

  Future<void> createNewLogTask({
    required String firebaseLogId,
    required String taskTitle,
  });

  Future<void> deleteLogTask({
    required String firebaseLogId,
    required String firebaseLogTaskId,
  });
}
