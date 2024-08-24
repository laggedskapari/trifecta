part of 'log_bloc.dart';

sealed class LogEvent extends Equatable {
  const LogEvent();
}

class LoadLogEvent extends LogEvent {
  final String firebaseLogId;

  const LoadLogEvent({required this.firebaseLogId});

  @override
  List<Object?> get props => [firebaseLogId];
}
