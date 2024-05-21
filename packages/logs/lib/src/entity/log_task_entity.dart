class LogTaskEntity {
  final logTaskTitle;
  final firebaseLogTaskId;

  const LogTaskEntity({
    required this.firebaseLogTaskId,
    required this.logTaskTitle,
  });

  Map<String, Object?> toFirestoreDocument() {
    return {
      'firebaseLogTaskId': firebaseLogTaskId,
      'logTaskTitle': logTaskTitle,
    };
  }

  static LogTaskEntity fromFirestoreDocument(Map<String, dynamic> doc) {
    return LogTaskEntity(
      logTaskTitle: doc['logTaskTitle'],
      firebaseLogTaskId: doc['firebaseLogTaskId'],
    );
  }
}
