class TrifectaUserEntity {
  final String trifectaFirebaseUID;
  final String username;
  final String emailAddress;
  final String colorScheme;
  final int completedTasks;
  final int abandonedTasks;
  final double totalFocusMinutes;
  final double totalBreakMinutes;
  final double successRate;


  const TrifectaUserEntity({
    required this.trifectaFirebaseUID,
    required this.username,
    required this.emailAddress,
    required this.abandonedTasks,
    required this.completedTasks,
    required this.colorScheme,
    required this.totalFocusMinutes,
    required this.totalBreakMinutes,
    required this.successRate,
  });


  Map<String, Object?> toFirebaseDocument() {
    return {
      'trifectaFirebaseUID': trifectaFirebaseUID,
    'username': username,
    'emailAddress': emailAddress,
    'colorScheme': colorScheme,
    'completedTasks': completedTasks,
    'abandonedTasks': abandonedTasks,
    'totalFocusMinutes': totalFocusMinutes,
    'totalBreakMinutes': totalBreakMinutes,
    'successRate': successRate,
    };
  }

  static TrifectaUserEntity fromFirebaseDocument(Map<String, dynamic> doc) {
    return TrifectaUserEntity(
      trifectaFirebaseUID: doc["trifectaFirebaseUID"],
      username: doc["username"],
      emailAddress: doc["emailAddress"],
      colorScheme: doc["colorScheme"],
      completedTasks: doc["completedTasks"],
      abandonedTasks: doc["abandonedTasks"],
      totalFocusMinutes: doc["totalFocusMinutes"],
      totalBreakMinutes: doc["totalBreakMinutes"],
      successRate: doc["successRate"],
    );
  }
}
