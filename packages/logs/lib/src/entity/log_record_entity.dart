class LogRecordEntity {
  final DateTime? logRecordDate;
  final List<dynamic> logRecordTasks;
  final bool? isCompleted;
  final int totalLogTasks;
  final int totalCompletedLogTasks;

  const LogRecordEntity({
    required this.logRecordDate,
    required this.logRecordTasks,
    required this.isCompleted,
    required this.totalLogTasks,
    required this.totalCompletedLogTasks,
  });

  Map<String, Object?> toFirebaseDocument() {
    return {
      'logRecordDate': logRecordDate,
      'logRecordTasks': logRecordTasks,
      'isCompleted': isCompleted,
      'totalLogTasks': totalLogTasks,
      'totalCompletedLogTasks': totalCompletedLogTasks,
    };
  }

  static LogRecordEntity fromFirebaseDocument(Map<String, dynamic>? doc) {
    return LogRecordEntity(
      logRecordDate: doc?['logRecordDate'].toDate(),
      logRecordTasks: doc?['logRecordTasks'],
      isCompleted: doc?['isCompleted'],
      totalLogTasks: doc?['totalLogTasks'],
      totalCompletedLogTasks: doc?['totalCompletedLogTasks'],
    );
  }
}
