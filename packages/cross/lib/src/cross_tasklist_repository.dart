import 'package:cross/src/model/models.dart';
import 'package:cross/src/model/cross_tasklist.dart';

abstract class CrossTaskListRepository {
  Stream<List<CrossTaskList>> getAllTaskLists();
  Future<void> createNewTaskList({
    required String taskListTitle,
  });

  Future<void> updateTaskList({
    required String taskListTitle,
    required String firebaseTaskListId,
  });

  Future<void> updateTaskListArchiveStatus({
    required String firebaseTaskListId,
    required bool isTaskListArchived,
  });

  Future<void> deleteTaskList({
    required String firebaseTaskListId,
  });
}
