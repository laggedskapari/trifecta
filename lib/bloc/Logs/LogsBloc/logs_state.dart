part of 'logs_bloc.dart';

enum LogStatus { initiate, processing, success, failure }

final class LogsState extends Equatable {
  final List<LogsLog> logs;
  final String? error;
  final LogStatus status;

  const LogsState._({
    this.status = LogStatus.initiate,
    this.logs = const [],
    this.error,
  });

  const LogsState.initiate() : this._();
  const LogsState.processing() : this._(status: LogStatus.processing);
  const LogsState.success({required List<LogsLog> logs}) : this._(status: LogStatus.success, logs: logs);
  const LogsState.failure({required String errorMessage}) : this._(status: LogStatus.failure, error: errorMessage);

  @override 
  List<Object?> get props => [logs, error, logs];
}
