import 'package:cross/src/entities/cross_task_entity.dart';
import 'package:equatable/equatable.dart';

class CrossTask extends Equatable {
  final String firebaseTaskId;
  final String taskTitle;
  final String taskId;
  final String firebaseTaskListId;
  final bool isCompleted;
  final bool isImportant;
  final DateTime createdOn;
  final DateTime? completedOn;

  const CrossTask({
    required this.firebaseTaskId,
    required this.taskId,
    required this.taskTitle,
    required this.createdOn,
    required this.firebaseTaskListId,
    this.completedOn,
    this.isCompleted = false,
    this.isImportant = false,
  });

  CrossTaskEntity toCrossTaskEntity() {
    return CrossTaskEntity(
      firebaseTaskListId: firebaseTaskListId,
      taskTitle: taskTitle,
      firebaseTaskId: firebaseTaskId,
      taskId: taskId,
      createdOn: createdOn,
      isCompleted: isCompleted,
      isImportant: isImportant,
      completedOn: completedOn,
    );
  }

  static CrossTask fromCrossTaskEntity(CrossTaskEntity entity) {
    return CrossTask(
      firebaseTaskId: entity.firebaseTaskId,
      taskId: entity.taskId,
      taskTitle: entity.taskTitle,
      createdOn: entity.createdOn,
      firebaseTaskListId: entity.firebaseTaskListId,
      completedOn: entity.completedOn,
      isCompleted: entity.isCompleted,
      isImportant: entity.isImportant,
    );
  }

  List<Object?> get props => [
        firebaseTaskListId,
        taskId,
        firebaseTaskId,
        taskTitle,
        createdOn,
        isImportant,
        isCompleted,
        completedOn,
      ];
}
