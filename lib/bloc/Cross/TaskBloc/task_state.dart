part of 'task_bloc.dart';

enum TaskStatus { initial, processing, success, failure }

final class TaskState extends Equatable {
  final TaskStatus status;
  final String? errorMessage;
  final List<CrossTask> crossTasks;
  final String firebaseTaskListId;

  const TaskState._({
    this.status = TaskStatus.initial,
    this.crossTasks = const [],
    this.firebaseTaskListId = '',
    this.errorMessage,
  });

  const TaskState.initial() : this._();

  const TaskState.processing() : this._(status: TaskStatus.processing);

  const TaskState.success({
    required List<CrossTask> crossTasks,
    required String firebaseTaskListId,
  }) : this._(status: TaskStatus.success, crossTasks: crossTasks, firebaseTaskListId: firebaseTaskListId);

  const TaskState.failure({
    required String errorMessage,
  }) : this._(status: TaskStatus.failure, errorMessage: errorMessage);

  @override
  List<Object?> get props => [status, errorMessage, crossTasks];
}
