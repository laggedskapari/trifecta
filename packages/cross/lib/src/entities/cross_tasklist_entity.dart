class CrossTaskListEntity {
  final String taskListId;
  final String taskListTitle;
  final DateTime createdOn;

  const CrossTaskListEntity({
    required this.taskListId,
    required this.taskListTitle,
    required this.createdOn,
  });

  Map<String, Object?> toFirestoreDocument() {
    return {
      'taskListId': taskListId,
      'taskListTitle': taskListTitle,
      'createdOn': createdOn,
    };
  }

  static CrossTaskListEntity fromFirestoreDocument(Map<String, dynamic> doc) {
    return CrossTaskListEntity(
      taskListId: doc['taskListId'],
      taskListTitle: doc['taskListTitle'],
      createdOn: doc['createdOn'],
    );
  }
}
