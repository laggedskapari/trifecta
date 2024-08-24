import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:log/logs_repository.dart';

part 'log_state.dart';
part 'log_event.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  final LogsLogRepository logsLogRepository;
  LogBloc({required this.logsLogRepository}) : super(const LogState.initiate()) {
    on<LoadLogEvent>((event, emit) async {
      emit(const LogState.processing());
      final log = await logsLogRepository.getLog(firebaseLogId: event.firebaseLogId);
      emit(LogState.success(log: log));
    });
    // on<IncreaseLogAttendanceEvent>((event, emit) async {
    //   try {
    //     await logsLogRepository.increaseLogAttendance(
    //       firebaseLogId: event.firebaseLogId,
    //     );
    //     add(LoadLogEvent(log: event.log));
    //   } catch (e) {
    //     emit(LogState.failure(errorMessage: e.toString()));
    //   }
    // });
    //
    // on<DecreaseLogAttendanceEvent>((event, emit) async {
    //   try {
    //     await logsLogRepository.decreaseLogAttendance(
    //       firebaseLogId: event.firebaseLogId,
    //     );
    //     add(LoadLogEvent(log: event.log));
    //   } catch (e) {
    //     emit(LogState.failure(errorMessage: e.toString()));
    //   }
    // });
  }
}
