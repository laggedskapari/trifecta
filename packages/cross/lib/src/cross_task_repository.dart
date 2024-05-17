import 'model/models.dart';

abstract class CrossTaskRepository {
  Stream<List<CrossTask>> getAllTasks({required String taskListId});
  Future<void> createTask({required String taskTitle, required String taskListId});
  Future<void> updateTaskComplete({required String taskListId, required String taskId, required bool isCompleted});
  Future<void> updateTaskImportance({required String taskListId, required String taskId, required bool isImportant});
  Future<void> updateTaskTitle({required String taskListId, required String taskId, required String taskTitle});
  Future<void> deleteTask({required String taskListId, required String taskId});
}
