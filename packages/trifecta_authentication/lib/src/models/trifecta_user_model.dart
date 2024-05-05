import 'package:equatable/equatable.dart';

class TrifectaUser extends Equatable {
  final String trifectaFirebaseUID;
  final String username;
  final String emailAddress;
  final String colorScheme;
  final int completedTasks;
  final int abandonedTasks;
  final double totalFocusMinutes;
  final double totalBreakMinutes;
  final double successRate;

  const TrifectaUser({
    required this.trifectaFirebaseUID,
    required this.username,
    required this.emailAddress,
    required this.colorScheme,
    this.completedTasks = 0,
    this.abandonedTasks = 0,
    this.totalFocusMinutes = 0.0,
    this.totalBreakMinutes = 0.0,
    this.successRate = 0.0,
  });

  static const emptyTrifectaUser = TrifectaUser(
    trifectaFirebaseUID: '',
    username: '',
    emailAddress: '',
    colorScheme: '',
  );

  TrifectaUser copyWith({
    String? trifectaFirebaseUID,
    String? username,
    String? emailAddress,
    String? colorScheme,
  }) {
    return TrifectaUser(
      trifectaFirebaseUID: trifectaFirebaseUID ?? this.trifectaFirebaseUID,
      username: username ?? this.username,
      emailAddress: emailAddress ?? this.emailAddress,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }

  TrifectaUserEntity toTrifectaUserEntity() {
    return TrifectaUserEntity(
      trifectaFirebaseUID: trifectaFirebaseUID,
      username: username,
      emailAddress: emailAddress,
      completedTasks: completedTasks,
      abandonedTasks: abandonedTasks,
      colorScheme: colorScheme,
      totalBreakMinutes: totalBreakMinutes,
      totalFocusMinutes: totalFocusMinutes,
      successRate: successRate,
    );
  }

  static TrifectaUser fromTrifectaUserEntity(TrifectaUserEntity entity) {
    return TrifectaUser(
      trifectaFirebaseUID: entity.trifectaFirebaseUID,
      username: entity.username,
      emailAddress: entity.emailAddress,
      colorScheme: entity.colorScheme,
      completedTasks: entity.completedTasks,
      abandonedTasks: entity.abandonedTasks,
      totalBreakMinutes: entity.totalBreakMinutes,
      totalFocusMinutes: entity.totalFocusMinutes,
      successRate: entity.successRate,
    );
  }

  @override
  List<Object?> get props => [
        trifectaFirebaseUID,
        username,
        emailAddress,
        completedTasks,
        abandonedTasks,
        colorScheme,
        successRate,
        totalBreakMinutes,
        totalFocusMinutes,
      ];
}
