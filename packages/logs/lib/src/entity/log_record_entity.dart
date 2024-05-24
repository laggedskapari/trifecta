class LogRecordEntity {
  final DateTime logRecordDate;
  final List<String> logRecordTasks;

  const LogRecordEntity({
    required this.logRecordDate,
    required this.logRecordTasks,
  });

  Map<String, Object?> toFirebaseDocument() {
    return {
      'logRecordDate': logRecordDate,
      'logRecordTasks': logRecordTasks,
    };
  }

  static LogRecordEntity fromFirebaseDocument(Map<String, dynamic> doc) {
    return LogRecordEntity(
      logRecordDate: doc['logRecordDate'],
      logRecordTasks: doc['logRecordTasks'],
    );
  }
}