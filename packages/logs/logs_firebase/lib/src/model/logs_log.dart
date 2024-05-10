import 'package:equatable/equatable.dart';

class LogsLog extends Equatable {
  final String logTitle;
  final String logId;
  final String logDescription;
  final DateTime logCreatedOn;
  final int logDuration;
  final double logAttendance;
  final double logCompletion;
  final int logSkips;

  const LogsLog({
    required this.logId,
    required this.logTitle,
    required this.logDescription,
    required this.logDuration,
    required this.logCreatedOn,
    required this.logAttendance,
    required this.logSkips,
    required this.logCompletion,
  });

  LogsLog copyWith({
    String? logTitle,
    String? logId,
    String? logDescription,
    DateTime? logCreatedOn,
    int? logDuration,
    double? logAttendance,
    double? logCompletion,
    int? logSkips,
  }) {
    return LogsLog(
      logId: logId ?? this.logId,
      logTitle: logTitle ?? this.logTitle,
      logSkips: logSkips ?? this.logSkips,
      logDescription: logDescription ?? this.logDescription,
      logCreatedOn: logCreatedOn ?? this.logCreatedOn,
      logCompletion: logCompletion ?? this.logCompletion,
      logDuration: logDuration ?? this.logDuration,
      logAttendance: logAttendance ?? this.logAttendance,
    );
  }

  @override
  List<Object?> get props => [
        logTitle,
        logDescription,
        logCreatedOn,
        logDuration,
        logAttendance,
        logCompletion,
        logSkips,
      ];
}
