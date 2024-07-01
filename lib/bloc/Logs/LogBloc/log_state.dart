part of 'log_bloc.dart';

enum LogStatus { initiate, success, processing, failure }

final class LogState extends Equatable {
  final LogsLog? log;
  final String? error;
  final LogStatus status;

  const LogState._({
    this.status = LogStatus.initiate,
    this.log,
    this.error,
  });

  const LogState.initiate() : this._();
  const LogState.processing() : this._(status: LogStatus.processing);
  const LogState.success({required LogsLog log})
      : this._(status: LogStatus.success, log: log);
  const LogState.failure({required String errorMessage})
      : this._(status: LogStatus.failure, error: errorMessage);

  @override 
  List<Object?> get props => [log, error, status];
}

