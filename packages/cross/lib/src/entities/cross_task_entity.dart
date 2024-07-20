class CrossTaskEntity {
  final String firebaseTaskId;
  final String taskId;
  final String taskTitle;
  final bool isImportant;
  final bool isCompleted;
  final DateTime createdOn;
  final String firebaseTaskListId;
  final DateTime? completedOn;
  final DateTime? firstAlert;
  final DateTime? secondAlert;

  const CrossTaskEntity({
    required this.firebaseTaskId,
    required this.taskId,
    required this.taskTitle,
    required this.isCompleted,
    required this.isImportant,
    required this.createdOn,
    required this.firebaseTaskListId,
    this.completedOn,
    this.firstAlert,
    this.secondAlert,
  });

  Map<String, Object?> toFirestoreDocument() {
    return {
      'firebaseTaskId': firebaseTaskId,
      'taskId': taskId,
      'firebaseTaskListId': firebaseTaskListId,
      'isImportant': isImportant,
      'isCompleted': isCompleted,
      'createdOn': createdOn,
      'completedOn': completedOn,
      'taskTitle': taskTitle,
      'firstAlert': firstAlert,
      'secondAlert': secondAlert,
    };
  }

  static CrossTaskEntity fromFirestoreDocument(Map<String, dynamic> doc) {
    return CrossTaskEntity(
      firebaseTaskId: doc['firebaseTaskId'],
      taskId: doc['taskId'],
      taskTitle: doc['taskTitle'],
      firebaseTaskListId: doc['firebaseTaskListId'],
      isCompleted: doc['isCompleted'],
      isImportant: doc['isImportant'],
      createdOn: doc['createdOn'].toDate(),
      completedOn: doc['completedOn'].toDate(),
      firstAlert: doc['firstAlert'].toDate(),
      secondAlert: doc['secondAlert'].toDate(),
    );
  }
}
