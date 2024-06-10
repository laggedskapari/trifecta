part of 'log_task_bloc.dart';

sealed class LogTaskEvent extends Equatable {
  const LogTaskEvent();
}

class LoadLogTasksEvent extends LogTaskEvent {
  final String firebaseLogId;

  const LoadLogTasksEvent({
    required this.firebaseLogId,
  });

  @override
  List<Object?> get props => [firebaseLogId];
}

class CreateNewLogTaskEvent extends LogTaskEvent {
  final String firebaseLogId;
  final List<LogTask> logTasks;

  const CreateNewLogTaskEvent({
    required this.firebaseLogId,
    required this.logTasks,
  });

  @override
  List<Object?> get props => [firebaseLogId, logTasks];
}

class DeleteLogTaskEvent extends LogTaskEvent {
  final String firebaseLogId;
  final String firebaseLogTaskId;

  const DeleteLogTaskEvent({
    required this.firebaseLogId,
    required this.firebaseLogTaskId,
  });

  @override 
  List<Object?> get props => [firebaseLogTaskId, firebaseLogTaskId];
}
