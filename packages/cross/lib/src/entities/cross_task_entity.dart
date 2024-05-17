class CrossTaskEntity {
  final String taskId;
  final String taskTitle;
  final bool isImportant;
  final bool isCompleted;
  final DateTime createdOn;
  final DateTime? completedOn;
  final String taskListId;

  const CrossTaskEntity({
    required this.taskId,
    required this.taskTitle,
    required this.isCompleted,
    required this.isImportant,
    required this.createdOn,
    required this.taskListId,
    this.completedOn,
  });

  Map<String, Object?> toFirestoreDocument() {
    return {
      'taskId': taskId,
      'taskListId': taskListId,
      'isImportant': isImportant,
      'isCompleted': isCompleted,
      'createdOn': createdOn,
      'completedOn': completedOn,
      'taskTitle': taskTitle,
    };
  }

  static CrossTaskEntity fromFirestoreDocument(Map<String, dynamic> doc) {
    return CrossTaskEntity(
      taskId: doc['taskId'],
      taskTitle: doc['taskTitle'],
      taskListId: doc['taskListId'],
      isCompleted: doc['isCompleted'],
      isImportant: doc['isImportant'],
      createdOn: doc['createdOn'],
      completedOn: doc['completedOn'],
    );
  }
}
