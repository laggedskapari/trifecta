import 'package:cross_firestore/src/model/cross_tasklist.dart';

abstract class CrossTaskListRepository {
  Stream<List<CrossTaskList>> getAllTaskLists();
  Future<void> createNewTaskList({required String taskListTitle});
  Future<void> deleteNewTaskList({required String taskListId});
}
