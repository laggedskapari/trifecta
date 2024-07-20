class CrossTaskListEntity {
  final String firebaseTaskListId;
  final String taskListId;
  final String taskListTitle;
  final DateTime createdOn;
  final bool isTaskListArchived;
  final int totalTasks;
  final int totalCompletedTasks;

  const CrossTaskListEntity({
    required this.firebaseTaskListId,
    required this.taskListId,
    required this.taskListTitle,
    required this.createdOn,
    this.isTaskListArchived = false,
    this.totalTasks = 0,
    this.totalCompletedTasks = 0,
  });

  Map<String, Object?> toFirestoreDocument() {
    return {
      'firebaseTaskListId': firebaseTaskListId,
      'taskListId': taskListId,
      'taskListTitle': taskListTitle,
      'createdOn': createdOn,
      'isTaskListArchived': isTaskListArchived,
      'totalTasks': totalTasks,
      'totalCompletedTasks': totalCompletedTasks,
    };
  }

  static CrossTaskListEntity fromFirestoreDocument(Map<String, dynamic> doc) {
    return CrossTaskListEntity(
      firebaseTaskListId: doc['firebaseTaskListId'],
      taskListId: doc['taskListId'],
      taskListTitle: doc['taskListTitle'],
      createdOn: doc['createdOn'].toDate(),
      isTaskListArchived: doc['isTaskListArchived'],
      totalCompletedTasks: doc['totalCompletedTasks'],
      totalTasks: doc['totalTasks'],
    );
  }
}
