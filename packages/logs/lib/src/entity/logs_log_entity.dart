class LogsLogEntity {
  final String firebaseLogId;
  final String logId;
  final String logTitle;
  final DateTime logCreatedOn;
  final int logDuration;
  final double successRate;
  final int allowedSkips;
  final int usedSkips;
  final bool isSuccess;

  const LogsLogEntity({
    required this.firebaseLogId,
    required this.logId,
    required this.logTitle,
    required this.logCreatedOn,
    required this.usedSkips,
    required this.isSuccess,
    required this.logDuration,
    required this.successRate,
    required this.allowedSkips,
  });

  Map<String, Object?> toFirestoreDocument() {
    return {
      'firebaseLogId': firebaseLogId,
      'logId': logId,
      'logTitle': logTitle,
      'logCreatedOn': logCreatedOn,
      'usedSkips': usedSkips,
      'isSuccess': isSuccess,
      'logDuration': logDuration,
      'successRate': successRate,
      'allowedSkips': allowedSkips,
    };
  }

  static LogsLogEntity fromFirestoreDocument(Map<String, dynamic> doc) {
    return LogsLogEntity(
      firebaseLogId: doc['firebaseLogId'],
      logId: doc['logId'],
      logTitle: doc['logTitle'],
      logCreatedOn: doc['logCreatedOn'],
      usedSkips: doc['usedSkips'],
      isSuccess: doc['isSuccess'],
      logDuration: doc['logDuration'],
      successRate: doc['successRate'],
      allowedSkips: doc['allowedSkips'],
    );
  }
}
