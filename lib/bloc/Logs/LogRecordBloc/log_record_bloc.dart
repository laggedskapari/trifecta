import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:log/logs_repository.dart';

part 'log_record_state.dart';
part 'log_record_event.dart';

class LogRecordBloc extends Bloc<LogRecordEvent, LogRecordState> {
  final LogRecordRepository logRecordRepository;

  LogRecordBloc({required this.logRecordRepository})
      : super(const LogRecordState.initiate()) {
    on<LoadTodayLogRecord>((event, emit) async {
      try {
        emit(const LogRecordState.processing());
        final todayLogRecord = await logRecordRepository.getTodayLogRecord(
          firebaseLogId: event.firebaseLogId,
        );
        emit(LogRecordState.success(
          logRecordTasks: todayLogRecord.logRecordTasks,
        ));
      } catch (e) {
        emit(LogRecordState.failure(errorMessage: e.toString()));
      }
    });

    on<CreateLogRecord>((event, emit) async {
      try {
        await logRecordRepository.createNewLogRecord(
          firebaseLogId: event.firebaseLogId,
          firebaseLogTaskId: event.firebaseLogTaskId,
          totalLogTasks: event.totalLogTasks,
        );
        add(LoadTodayLogRecord(firebaseLogId: event.firebaseLogId));
      } catch (e) {
        emit(LogRecordState.failure(errorMessage: e.toString()));
      }
    });
    on<RemoveTaskFromLogRecord>((event, emit) async {
      try {
        await logRecordRepository.removeTaskFromLogRecord(
          firebaseLogId: event.firebaseLogId,
          firebaseLogTaskId: event.firebaseLogTaskId,
        );
        add(LoadTodayLogRecord(firebaseLogId: event.firebaseLogId));
      } catch (e) {
        emit(LogRecordState.failure(errorMessage: e.toString()));
      }
    });
  }
}
