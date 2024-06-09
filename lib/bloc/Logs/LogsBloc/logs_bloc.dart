import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:log/logs_repository.dart';

part 'logs_event.dart';
part 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  final LogsLogRepository logsLogRepository;

  LogsBloc({required this.logsLogRepository}) : super(const LogsState.initiate()) {
    on<LoadLogsEvent>((event, emit) {});
    on<CreateNewLogEvent>((event, emit) {});
    on<DeleteLogEvent>((event, emit) {});
  }
}
