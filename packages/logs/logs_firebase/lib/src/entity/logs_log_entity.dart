class LogsLogEntity {
  final String logTitle;
  final String logId;
  final String logDescription;
  final DateTime logCreatedOn;
  final int logDuration;
  final double logAttendance;
  final double logCompletion;
  final int logSkips;

  const LogsLogEntity({
    required this.logId,
    required this.logSkips,
    required this.logCompletion,
    required this.logAttendance,
    required this.logTitle,
    required this.logDuration,
    required this.logCreatedOn,
    required this.logDescription,
  });

  Map<String, Object> toFirebaseDocument() {
    return {
      'logId': logId,
      'logSkips': logSkips,
      'logCompletion': logCompletion,
      'logAttendance': logAttendance,
      'logTitle': logTitle,
      'logDuration': logDuration,
      'logCreatedOn': logCreatedOn,
      'logDescription': logDescription,
    };
  }

  static LogsLogEntity fromFirebaseDocument(Map<String, dynamic> doc) {
    return LogsLogEntity(
      logId: doc['logId'],
      logDescription: doc['logDescription'],
      logSkips: doc['logSkips'],
      logTitle: doc['logTitle'],
      logDuration: doc['logDuration'],
      logCreatedOn: doc['logCreatedOn'],
      logCompletion: doc['logCompletion'],
      logAttendance: doc['logAttendance'],
    );
  }
}
