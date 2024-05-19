import 'package:cross/src/entities/entities.dart';
import 'package:equatable/equatable.dart';

class CrossTaskList extends Equatable {
  final String taskListTitle;
  final DateTime createdOn;
  final String taskListId;
  final String firebaseTaskListId;

  const CrossTaskList({
    required this.firebaseTaskListId,
    required this.taskListId,
    required this.taskListTitle,
    required this.createdOn,
  });

  CrossTaskListEntity toCrossTaskListEntity() {
    return CrossTaskListEntity(
      taskListId: taskListId,
      firebaseTaskListId: firebaseTaskListId,
      taskListTitle: taskListTitle,
      createdOn: createdOn,
    );
  }

  static CrossTaskList fromCrossTaskListEntity(CrossTaskListEntity entity) {
    return CrossTaskList(
      firebaseTaskListId: entity.firebaseTaskListId,
      taskListId: entity.taskListId,
      taskListTitle: entity.taskListTitle,
      createdOn: entity.createdOn,
    );
  }

  @override
  List<Object?> get props => [
        taskListTitle,
        firebaseTaskListId,
        taskListId,
        createdOn,
      ];
}
