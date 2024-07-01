part of 'log_bloc.dart';

sealed class LogEvent extends Equatable {
  const LogEvent();
}

class LoadLogEvent extends LogEvent {
  final LogsLog log;

  const LoadLogEvent({required this.log});

  @override
  List<Object?> get props => [log];
}
