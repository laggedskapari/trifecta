import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:log/logs_repository.dart';

part 'log_state.dart';
part 'log_event.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  LogBloc() : super(const LogState.initiate()) {
    on<LoadLogEvent>((event, emit) {
      emit(const LogState.processing());
      emit(LogState.success(log: event.log));
    });
  }
}
