import 'package:log/src/model/models.dart';

abstract class LogsTaskRepository {
  Stream<List<LogTask>> getAllLogTasks({required String firebaseLogId});
  Future<void> createNewLogTask({required String firebaseLogId});
  Future<void> updateCrossLogTask({required String firebaseLogId, required bool isCrossed});
}
