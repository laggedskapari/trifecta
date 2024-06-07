import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cross/cross_repository.dart';
import 'package:equatable/equatable.dart';

part 'task_state.dart';
part 'task_event.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final CrossTaskRepository crossTaskRepository;

  TaskBloc({required this.crossTaskRepository})
      : super(const TaskState.initial()) {
    on<LoadTasksEvent>((event, emit) async {
      try {
        emit(const TaskState.processing());
        final crossTasks = await crossTaskRepository
            .getAllTasks(
              firebaseTaskListId: event.firebaseTaskListId,
            )
            .first;
        emit(TaskState.success(
          crossTasks: crossTasks,
          firebaseTaskListId: event.firebaseTaskListId,
        ));
      } catch (e) {
        emit(TaskState.failure(errorMessage: e.toString()));
      }
    });

    on<CreateNewTaskEvent>((event, emit) async {
      try {
        await crossTaskRepository.createNewCrossTask(
          firebaseTaskListId: event.firebaseTaskListId,
          taskTitle: event.taskTitle,
        );
        add(LoadTasksEvent(firebaseTaskListId: event.firebaseTaskListId));
      } catch (e) {
        log(e.toString());
      }
    });
    on<UpdateTaskImportanceStatusEvent>((event, emit) async {
      try {
        await crossTaskRepository.updateTaskImportance(
          firebaseTaskListId: event.firebaseTaskListId,
          firebaseTaskId: event.firebaseTaskId,
          isImportant: event.taskImportanceStatus,
        );
        add(LoadTasksEvent(firebaseTaskListId: event.firebaseTaskListId));
      } catch (e) {
        log(e.toString());
      }
    });
    on<UpdateTaskCompletionStatusEvent>((event, emit) async {
      try {
        await crossTaskRepository.updateTaskCompletion(
          firebaseTaskListId: event.firebaseTaskListId,
          firebaseTaskId: event.firebaseTaskId,
          isCompleted: event.taskCompletionStatus,
        );
        add(LoadTasksEvent(firebaseTaskListId: event.firebaseTaskListId));
      } catch (e) {
        log(e.toString());
      }
    });
    on<DeleteTaskEvent>((event, emit) async {
      try {
        await crossTaskRepository.deleteTask(
          firebaseTaskListId: event.firebaseTaskListId,
          firebaseTaskId: event.firebaseTaskId,
        );
        add(LoadTasksEvent(firebaseTaskListId: event.firebaseTaskListId));
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
