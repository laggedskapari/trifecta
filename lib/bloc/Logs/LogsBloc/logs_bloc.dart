import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:log/logs_repository.dart';

part 'logs_event.dart';
part 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  final LogsLogRepository logsLogRepository;

  LogsBloc({required this.logsLogRepository})
      : super(const LogsState.initiate()) {
    on<LoadLogsEvent>((event, emit) async {
      try {
        emit(const LogsState.processing());
        final logs = await logsLogRepository.getAllLogs().first;
        emit(LogsState.success(logs: logs));
      } catch (e) {
        emit(LogsState.failure(errorMessage: e.toString()));
      }
    });

    on<CreateNewLogEvent>((event, emit) async {
      try {
        await logsLogRepository.createNewLogsLog(
          logTitle: event.logTitle,
          logDuration: event.logDuration,
          logTasks: event.logTasks,
        );
        add(LoadLogsEvent());
      } catch (e) {
        emit(LogsState.failure(errorMessage: e.toString()));
      }
    });
    on<DeleteLogEvent>((event, emit) async {
      try {
        await logsLogRepository.deleteLogsLog(
          firebaseLogId: event.firebaseLogId,
        );

        add(LoadLogsEvent());
      } catch (e) {
        emit(LogsState.failure(errorMessage: e.toString()));
      }
    });

    on<IncreaseLogAttendanceEvent>((event, emit) async {
      try {
        await logsLogRepository.increaseLogAttendance(
          firebaseLogId: event.firebaseLogId,
        );
        add(LoadLogsEvent());
      } catch (e) {
        emit(LogsState.failure(errorMessage: e.toString()));
      }
    });

    on<DecreaseLogAttendanceEvent>((event, emit) async {
      try {
        await logsLogRepository.decreaseLogAttendance(
          firebaseLogId: event.firebaseLogId,
        );
        add(LoadLogsEvent());
      } catch (e) {
        emit(LogsState.failure(errorMessage: e.toString()));
      }
    });
  }
}
