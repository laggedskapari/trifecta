import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cross/cross_repository.dart';
import 'package:equatable/equatable.dart';

part 'tasklist_state.dart';
part 'tasklist_event.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final CrossTaskListRepository crossTaskListRepository;

  TaskListBloc({required this.crossTaskListRepository})
      : super(const TaskListState.initial()) {
    on<LoadTaskListsEvent>((event, emit) async {
      try {
        emit(const TaskListState.processing());
        final taskLists = await crossTaskListRepository.getAllTaskLists().first;
        emit(TaskListState.success(crossTaskLists: taskLists));
      } catch (e) {
        emit(TaskListState.failure(errorMessage: e.toString()));
        log(e.toString());
      }
    });
    on<CreateNewTaskListEvent>((event, emit) async {
      try {
        await crossTaskListRepository.createNewTaskList(
            taskListTitle: event.taskListTitle);
        add(LoadTaskListsEvent());
      } catch (e) {
        log(e.toString());
      }
    });
    on<UpdateTaskListEvent>((event, emit) async {
      try {
        await crossTaskListRepository.updateTaskListTitle(
          taskListTitle: event.taskListTitle,
          firebaseTaskListId: event.taskListFirebaseId,
        );
        add(LoadTaskListsEvent());
      } catch (e) {
        log(e.toString());
      }
    });
    on<DeleteTaskListEvent>((event, emit) async {
      try {
        await crossTaskListRepository.deleteTaskList(
            firebaseTaskListId: event.taskListFirebaseId);
        add(LoadTaskListsEvent());
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
