import 'package:cross/src/entities/entities.dart';
import 'package:equatable/equatable.dart';

class CrossTaskList extends Equatable {
  final String taskListTitle;
  final DateTime createdOn;
  final String taskListId;
  final String firebaseTaskListId;
  final bool isTaskListArchived;
  final int totalTasks;
  final int totalCompletedTasks;

  const CrossTaskList({
    required this.firebaseTaskListId,
    required this.taskListId,
    required this.taskListTitle,
    required this.createdOn,
    this.isTaskListArchived = false,
    this.totalCompletedTasks = 0,
    this.totalTasks = 0,
  });

  CrossTaskListEntity toCrossTaskListEntity() {
    return CrossTaskListEntity(
      taskListId: taskListId,
      firebaseTaskListId: firebaseTaskListId,
      taskListTitle: taskListTitle,
      createdOn: createdOn,
      isTaskListArchived: isTaskListArchived,
      totalTasks: totalTasks,
      totalCompletedTasks: totalCompletedTasks,
    );
  }

  static CrossTaskList fromCrossTaskListEntity(CrossTaskListEntity entity) {
    return CrossTaskList(
      firebaseTaskListId: entity.firebaseTaskListId,
      taskListId: entity.taskListId,
      taskListTitle: entity.taskListTitle,
      createdOn: entity.createdOn,
      isTaskListArchived: entity.isTaskListArchived,
      totalTasks: entity.totalTasks,
      totalCompletedTasks: entity.totalCompletedTasks,
    );
  }

  @override
  List<Object?> get props => [
        taskListTitle,
        firebaseTaskListId,
        taskListId,
        createdOn,
        isTaskListArchived,
        totalTasks,
        totalCompletedTasks,
      ];
}
