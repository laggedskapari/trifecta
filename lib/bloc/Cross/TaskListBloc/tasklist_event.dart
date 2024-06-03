part of 'tasklist_bloc.dart';

sealed class TaskListEvent extends Equatable {
  const TaskListEvent();
}

class LoadTaskListsEvent extends TaskListEvent {


  @override 
  List<Object?> get props => [];
}

class CreateNewTaskListEvent extends TaskListEvent {
  final String taskListTitle;

  const CreateNewTaskListEvent({required this.taskListTitle});

  @override 
  List<Object?> get props => [taskListTitle];
}

class UpdateTaskListEvent extends TaskListEvent {
  final String taskListTitle;
  final String taskListFirebaseId;

  const UpdateTaskListEvent({required this.taskListTitle, required this.taskListFirebaseId});

  @override 
  List<Object?> get props => [taskListTitle, taskListFirebaseId];
}

class DeleteTaskListEvent extends TaskListEvent {
  final String taskListFirebaseId;

  const DeleteTaskListEvent({required this.taskListFirebaseId});

  @override 
  List<Object?> get props => [taskListFirebaseId];
}
