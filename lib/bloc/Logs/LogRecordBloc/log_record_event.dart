part of 'log_record_bloc.dart';

sealed class LogRecordEvent extends Equatable {
  const LogRecordEvent();
}

class LoadTodayLogRecord extends LogRecordEvent {
  final String firebaseLogId;

  const LoadTodayLogRecord({
    required this.firebaseLogId,
  });

  @override
  List<Object?> get props => [firebaseLogId];
}

class CreateLogRecord extends LogRecordEvent {
  final String firebaseLogId;
  final String logRecordDate;
  final String firebaseLogTaskId;

  const CreateLogRecord({
    required this.firebaseLogId,
    required this.firebaseLogTaskId,
    required this.logRecordDate,
  });

  @override 
  List<Object?> get props => [firebaseLogId, logRecordDate, firebaseLogTaskId];
}

class DeleteLogRecord extends LogRecordEvent {
  final String firebaseLogId;
  final String firebaseLogTaskId;

  const DeleteLogRecord({required this.firebaseLogId ,required this.firebaseLogTaskId, });

  @override 
  List<Object?> get props => [firebaseLogId, firebaseLogTaskId];
}

class RemoveTaskFromLogRecord extends LogRecordEvent {
  final String firebaseLogId;
  final String firebaseLogTaskId;

  const RemoveTaskFromLogRecord({required this.firebaseLogId, required this.firebaseLogTaskId});

  @override 
  List<Object?> get props => [firebaseLogId, firebaseLogTaskId];
}
