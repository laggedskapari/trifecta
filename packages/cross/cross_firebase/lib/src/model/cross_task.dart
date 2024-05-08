import 'package:equatable/equatable.dart';

class CrossTask extends Equatable {
  final String taskTitle;
  final String taskId;
  final String taskListId;
  final bool isCompleted;
  final bool isImportant;
  final DateTime createdOn;
  final DateTime? completedOn;

  const CrossTask({
    required this.taskId,
    required this.taskTitle,
    required this.createdOn,
    required this.taskListId,
    this.completedOn,
    this.isCompleted = false,
    this.isImportant = false,
  });

  CrossTask copyWith({
    String? taskId,
    String? taskTitle,
    DateTime? createdOn,
    DateTime? completedOn,
    bool? isCompleted,
    bool? isImportant,
    String? taskListId,
  }) {
    return CrossTask(
      taskId: taskId ?? this.taskId,
      taskTitle: taskTitle ?? this.taskTitle,
      taskListId: taskListId ?? this.taskListId,
      createdOn: createdOn ?? this.createdOn,
      isCompleted: isCompleted ?? this.isCompleted,
      isImportant: isImportant ?? this.isImportant,
      completedOn: completedOn ?? this.completedOn,
    );
  }
}

