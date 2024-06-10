part of 'log_task_bloc.dart';

enum LogTaskStatus { initiate, processing, success, failure }

final class LogTaskState extends Equatable {
  final LogTaskStatus status;
  final String? errorMessage;
  final List<LogTask> logTasks;

  const LogTaskState._({
    this.logTasks = const [],
    this.status = LogTaskStatus.initiate,
    this.errorMessage,
  });

  const LogTaskState.initiate() : this._();

  const LogTaskState.processing() : this._(status: LogTaskStatus.processing);

  const LogTaskState.success({required List<LogTask> logTasks}) : this._(status: LogTaskStatus.success, logTasks: logTasks);

  const LogTaskState.failure({required String errorMessage}) : this._(status: LogTaskStatus.failure, errorMessage: errorMessage);

  @override 
  List<Object?> get props => [status, errorMessage, logTasks];
}
