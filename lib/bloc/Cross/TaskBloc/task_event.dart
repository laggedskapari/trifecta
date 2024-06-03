part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();
}

class LoadTasksEvent extends TaskEvent {
  final String firebaseTaskListId;

  const LoadTasksEvent({
    required this.firebaseTaskListId,
  });

  @override
  List<Object?> get props => [firebaseTaskListId];
}

class CreateNewTaskEvent extends TaskEvent {
  final String firebaseTaskListId;
  final String taskTitle;

  const CreateNewTaskEvent({
    required this.taskTitle,
    required this.firebaseTaskListId,
  });

  @override
  List<Object?> get props => [taskTitle, firebaseTaskListId];
}

class UpdateTaskCompletionStatusEvent extends TaskEvent {
  final String firebaseTaskListId;
  final String firebaseTaskId;
  final bool taskCompletionStatus;

  const UpdateTaskCompletionStatusEvent({
    required this.firebaseTaskListId,
    required this.firebaseTaskId,
    required this.taskCompletionStatus,
  });

  @override
  List<Object?> get props => [firebaseTaskListId, firebaseTaskId];
}

class UpdateTaskImportanceStatusEvent extends TaskEvent {
  final String firebaseTaskListId;
  final String firebaseTaskId;
  final bool taskImportanceStatus;

  const UpdateTaskImportanceStatusEvent({
    required this.firebaseTaskListId,
    required this.firebaseTaskId,
    required this.taskImportanceStatus,
  });

  @override
  List<Object?> get props => [firebaseTaskId, firebaseTaskListId];
}

class DeleteTaskEvent extends TaskEvent {
  final String firebaseTaskListId;
  final String firebaseTaskId;

  const DeleteTaskEvent({
    required this.firebaseTaskListId,
    required this.firebaseTaskId,
  });

  @override
  List<Object?> get props => [firebaseTaskListId, firebaseTaskId];
}
