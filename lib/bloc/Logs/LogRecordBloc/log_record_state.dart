part of 'log_record_bloc.dart';

enum LogRecordStatus { initiate, processing, success, failure }

final class LogRecordState extends Equatable {
  final List<dynamic> logRecordTasks;
  final String? errorMessage;
  final LogRecordStatus status;

  const LogRecordState._({
    this.status = LogRecordStatus.initiate,
    this.logRecordTasks = const [],
    this.errorMessage,
  });

  const LogRecordState.initiate() : this._();
  const LogRecordState.processing() : this._(status: LogRecordStatus.processing);
  const LogRecordState.success({required List<dynamic> logRecordTasks}) : this._( status: LogRecordStatus.success, logRecordTasks: logRecordTasks);
  const LogRecordState.failure({required String errorMessage}) : this._(status: LogRecordStatus.failure, errorMessage: errorMessage);

  @override 
  List<Object?> get props => [logRecordTasks, errorMessage, status];
}
