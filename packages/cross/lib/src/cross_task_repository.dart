import 'model/models.dart';

abstract class CrossTaskRepository {
  Stream<List<CrossTask>> getAllTasks({
    required String firebaseTaskListId,
  });

  Future<void> createNewCrossTask({
    required String firebaseTaskListId,
    required String taskTitle,
  });

  Future<void> updateTaskCompletion({
    required String firebaseTaskListId,
    required String firebaseTaskId,
    required bool isCompleted,
  });

  Future<void> updateTaskImportance({
    required String firebaseTaskListId,
    required String firebaseTaskId,
    required bool isImportant,
  });

  Future<void> updateTask({
    required String firebaseTaskListId,
    required String firebaseTaskId,
    required String taskTitle,
    required DateTime? firstAlert,
    required DateTime? secondAlert,
  });

  Future<void> deleteTask({
    required String firebaseTaskListId,
    required String firebaseTaskId,
  });
}
