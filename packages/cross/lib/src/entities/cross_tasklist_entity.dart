class CrossTaskListEntity {
  final String firebaseTaskListId;
  final String taskListId;
  final String taskListTitle;
  final DateTime createdOn;

  const CrossTaskListEntity({
    required this.firebaseTaskListId,
    required this.taskListId,
    required this.taskListTitle,
    required this.createdOn,
  });

  Map<String, Object?> toFirestoreDocument() {
    return {
      'firebaseTaskListId': firebaseTaskListId,
      'taskListId': taskListId,
      'taskListTitle': taskListTitle,
      'createdOn': createdOn,
    };
  }

  static CrossTaskListEntity fromFirestoreDocument(Map<String, dynamic> doc) {
    return CrossTaskListEntity(
      firebaseTaskListId: doc['firebaseTaskListId'],
      taskListId: doc['taskListId'],
      taskListTitle: doc['taskListTitle'],
      createdOn: doc['createdOn'].toDate(),
    );
  }
}
