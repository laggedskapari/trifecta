part of 'logs_bloc.dart';

sealed class LogsEvent extends Equatable {
  const LogsEvent();
}

class LoadLogsEvent extends LogsEvent {
  @override 
  List<Object?> get props => [];
}

class CreateNewLogEvent extends LogsEvent {
  final String logTitle;
  final List<LogTask> logTasks;
  final int logDuration;

  const CreateNewLogEvent({required this.logTitle, required this.logTasks, required this.logDuration,});

  @override 
  List<Object?> get props => [logTitle, logTasks, logDuration];
}

class DeleteLogEvent extends LogsEvent {
  final String firebaseLogId;

  const DeleteLogEvent({required this.firebaseLogId});

  @override 
  List<Object?> get props => [firebaseLogId];
}
