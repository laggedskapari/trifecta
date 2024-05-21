import 'package:equatable/equatable.dart';
import 'package:log/src/entity/log_task_entity.dart';

class LogTask extends Equatable {
  final String logTaskTitle;
  final String firebaseLogTaskId;

  const LogTask({
    required this.logTaskTitle,
    required this.firebaseLogTaskId,
  });

  LogTaskEntity toLogTaskEntity() {
    return LogTaskEntity(
      logTaskTitle: logTaskTitle,
      firebaseLogTaskId: firebaseLogTaskId,
    );
  }

  static LogTask fromLogTaskEntity(LogTaskEntity entity) {
    return LogTask(
      logTaskTitle: entity.logTaskTitle,
      firebaseLogTaskId: entity.firebaseLogTaskId,
    );
  }

  @override
  List<Object?> get props => [
        logTaskTitle,
        firebaseLogTaskId,
      ];
}
