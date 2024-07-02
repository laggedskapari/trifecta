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
      emit(const LogRecordState.processing());
      final logRecords = await logRecordRepository.getAllLogRecords(
          firebaseLogId: event.firebaseLogId).first;
      final todayLogRecord = await logRecordRepository.getTodayLogRecord(firebaseLogId: event.firebaseLogId);
      print(todayLogRecord);
      print(logRecords.toList());
      emit(LogRecordState.success(logRecordTasks: todayLogRecord.logRecordTasks));
    });

    on<CreateLogRecord>((event, emit) async {
      await logRecordRepository.createNewLogRecord(
        firebaseLogId: event.firebaseLogId,
        firebaseLogTaskId: event.firebaseLogTaskId,
        logRecordDate: event.logRecordDate,
      );
    });
  }
}
