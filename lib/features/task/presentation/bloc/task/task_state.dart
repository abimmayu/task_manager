part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Tasks> tasksList;

  const TaskLoaded(this.tasksList);

  @override
  List<Object> get props => [tasksList];
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}

class TaskLoading extends TaskState {}

class TaskCreated extends TaskState {}

class TaskUpdated extends TaskState {}

class TaskDeleted extends TaskState {}

class TaskAdded extends TaskState {}

class TaskSynced extends TaskState {}

class TaskNotificationScheduled extends TaskState {}
