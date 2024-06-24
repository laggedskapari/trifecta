part of 'logs_bloc.dart';

enum LogsStatus { initiate, processing, success, failure }

final class LogsState extends Equatable {
  final List<LogsLog> logs;
  final String? error;
  final LogsStatus status;

  const LogsState._({
    this.status = LogsStatus.initiate,
    this.logs = const [],
    this.error,
  });

  const LogsState.initiate() : this._();
  const LogsState.processing() : this._(status: LogsStatus.processing);
  const LogsState.success({required List<LogsLog> logs})
      : this._(status: LogsStatus.success, logs: logs);
  const LogsState.failure({required String errorMessage})
      : this._(status: LogsStatus.failure, error: errorMessage);

  @override
  List<Object?> get props => [logs, error, status];
}
