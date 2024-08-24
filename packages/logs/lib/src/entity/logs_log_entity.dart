class LogsLogEntity {
  final String firebaseLogId;
  final String logId;
  final String logTitle;
  final DateTime logCreatedOn;
  final int logDuration;
  final double successRate;
  final bool isSuccess;
  final DateTime logEndDate;
  final DateTime logCompletedOn;
  final DateTime logInitDate;
  final int logAttendance;
  final int totalLogTasks;

  const LogsLogEntity({
    required this.logCompletedOn,
    required this.logEndDate,
    required this.firebaseLogId,
    required this.logId,
    required this.logTitle,
    required this.logCreatedOn,
    required this.isSuccess,
    required this.logDuration,
    required this.successRate,
    required this.logInitDate,
    required this.logAttendance,
    required this.totalLogTasks,
  });

  Map<String, Object?> toFirestoreDocument() {
    return {
      'firebaseLogId': firebaseLogId,
      'logId': logId,
      'logTitle': logTitle,
      'logCreatedOn': logCreatedOn,
      'isSuccess': isSuccess,
      'logDuration': logDuration,
      'successRate': successRate,
      'logEndDate': logEndDate,
      'logCompletedOn': logCompletedOn, 
      'logInitDate': logInitDate,
      'logAttendance': logAttendance,
      'totalLogTasks': totalLogTasks,
    };
  }

  static LogsLogEntity fromFirestoreDocument(Map<String, dynamic> doc) {
    return LogsLogEntity(
      logInitDate: doc['logInitDate'].toDate(),
      logEndDate: doc['logEndDate'].toDate(),
      logCompletedOn: doc['logCompletedOn'].toDate(),
      firebaseLogId: doc['firebaseLogId'],
      logId: doc['logId'],
      logTitle: doc['logTitle'],
      logCreatedOn: doc['logCreatedOn'].toDate(),
      isSuccess: doc['isSuccess'],
      logDuration: doc['logDuration'],
      successRate: doc['successRate'],
      logAttendance: doc['logAttendance'],
      totalLogTasks: doc['totalLogTasks'],
    );
  }
}
