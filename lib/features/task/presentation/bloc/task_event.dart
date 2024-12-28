part of 'task_bloc.dart';

@immutable
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final Tasks task;
  const AddTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class FetchTasksEvent extends TaskEvent {}

class SearchTasksEvent extends TaskEvent {
  final String query;
  const SearchTasksEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterTasksEvent extends TaskEvent {
  final TaskStatus status;
  const FilterTasksEvent(this.status);

  @override
  List<Object?> get props => [status];
}

class UpdateTaskEvent extends TaskEvent {
  final Tasks task;
  const UpdateTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final int id;
  const DeleteTaskEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchUnsyncedTasksEvent extends TaskEvent {}

class SyncTasksEvent extends TaskEvent {
  final String serverUrl;
  const SyncTasksEvent(this.serverUrl);

  @override
  List<Object?> get props => [serverUrl];
}
