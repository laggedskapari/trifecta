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
      } catch (e) {
        print(e.toString());
        print('You messed up!');

      }
    });
    on<DeleteLogEvent>((event, emit) {});
  }
}
