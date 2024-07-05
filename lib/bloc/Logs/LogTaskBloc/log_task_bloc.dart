import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:log/logs_repository.dart';

part 'log_task_state.dart';
part 'log_task_event.dart';

class LogTaskBloc extends Bloc<LogTaskEvent, LogTaskState> {
  final LogsTaskRepository logsTaskRepository;

  LogTaskBloc({required this.logsTaskRepository})
      : super(const LogTaskState.initiate()) {
    on<LoadLogTasksEvent>((event, emit) async {
      try {
        final logTasks = await logsTaskRepository
            .getAllLogTasks(firebaseLogId: event.firebaseLogId)
            .first;
        emit(LogTaskState.success(logTasks: logTasks));
      } catch (e) {
        emit(LogTaskState.failure(errorMessage: e.toString()));
      }
    });
  }
}
