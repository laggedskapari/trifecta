part of 'tasklist_bloc.dart';

enum TaskListStatus { initial, success, failure, processing }

final class TaskListState extends Equatable {
  final String? errorMessage;
  final TaskListStatus status;
  final List<CrossTaskList> crossTaskLists;

  const TaskListState._({
    this.status = TaskListStatus.initial,
    this.crossTaskLists = const [],
    this.errorMessage,
  });
  const TaskListState.initial() : this._();
  const TaskListState.success({required List<CrossTaskList> crossTaskLists})
      : this._(
          crossTaskLists: crossTaskLists,
          status: TaskListStatus.success,
        );
  const TaskListState.failure({required String errorMessage})
      : this._(
          errorMessage: errorMessage,
          status: TaskListStatus.failure,
        );
  const TaskListState.processing()
      : this._(
          status: TaskListStatus.processing,
        );

  @override
  List<Object?> get props => [errorMessage, status, crossTaskLists];
}
