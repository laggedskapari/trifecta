part of 'log_record_bloc.dart';

sealed class LogRecordEvent extends Equatable {
  const LogRecordEvent();
}

class LoadTodayLogRecord extends LogRecordEvent {
  final String firebaseLogId;
  final String today;

  const LoadTodayLogRecord({
    required this.firebaseLogId,
    required this.today,
  });

  @override
  List<Object?> get props => [firebaseLogId, today];
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
