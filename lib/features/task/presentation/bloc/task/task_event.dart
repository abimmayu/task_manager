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

class SearchAndFilterTasksEvent extends TaskEvent {
  final String? query;
  final String? status;
  const SearchAndFilterTasksEvent({this.query, this.status});

  @override
  List<Object?> get props => [query, status];
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

class ScheduleNotificationEvent extends TaskEvent {
  final int id;
  final String title;
  final String body;
  final DateTime dueDate;
  const ScheduleNotificationEvent(this.id, this.title, this.body, this.dueDate);

  @override
  List<Object?> get props => [id, title, body, dueDate];
}
