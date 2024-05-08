import 'package:equatable/equatable.dart';

class CrossTaskList extends Equatable {
  final String taskListTitle;
  final String createdOn;
  final String taskListId;

  const CrossTaskList({
    required this.taskListId,
    required this.taskListTitle,
    required this.createdOn,
  });

  CrossTaskList copyWith({
    String? taskListId,
    String? taskListTitle,
    String? createdOn,
  }) {
    return CrossTaskList(
      taskListId: taskListId ?? this.taskListId,
      taskListTitle: taskListTitle ?? this.taskListTitle,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  CrossTaskListEntity toCrossTaskListEntity() {
    return CrossTaskListEntity(
      taskListId: taskListId,
      taskListTitle: taskListTitle,
      createdOn: createdOn,
    );
  }

  static CrossTaskList fromCrossTaskListEntity(CrossTaskListEntity entity) {
    return CrossTaskList(
      taskListId: entity.taskListId,
      taskListTitle: entity.taskListTitle,
      createdOn: entity.createdOn,
    );
  }

  @override
  List<Object?> get props => [
        taskListTitle,
        taskListId,
        createdOn,
      ];
}
