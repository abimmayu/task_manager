import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';
import 'package:task_manager/features/task/domain/usecases/task_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskUsecase taskUsecase;

  TaskBloc(this.taskUsecase) : super(TaskInitial()) {
    on<FetchTasksEvent>(_fetchTasks);
    on<FetchUnsyncedTasksEvent>(_fetchUnsyncedTasks);
    on<SearchTasksEvent>(_searchTasks);
    on<FilterTasksEvent>(_filterTasks);
    on<AddTaskEvent>(_addTask);
    on<UpdateTaskEvent>(_updateTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<SyncTasksEvent>(_syncTasks);
  }

  Future<void> _fetchTasks(
      FetchTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    final response = await taskUsecase.fetchTasks();

    response.fold(
      (l) => emit(TaskError(l.message!)),
      (r) => emit(TaskLoaded(r)),
    );
  }

  Future<void> _fetchUnsyncedTasks(
      FetchUnsyncedTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    final response = await taskUsecase.fetchUnsyncedTasks();

    response.fold(
      (l) => emit(TaskError(l.message!)),
      (r) => emit(TaskLoaded(r)),
    );
  }

  Future<void> _searchTasks(
      SearchTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    final response = await taskUsecase.searchTasks(event.query);

    response.fold(
      (l) => emit(TaskError(l.message!)),
      (r) => emit(TaskLoaded(r)),
    );
  }

  Future<void> _filterTasks(
      FilterTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    final response = await taskUsecase.filterTasks(event.status);
    response.fold(
      (l) => emit(TaskError(l.message!)),
      (r) => emit(TaskLoaded(r)),
    );
  }

  Future<void> _addTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    final response = await taskUsecase.createTask(event.task);
    response.fold(
      (l) => emit(TaskError(l.message!)),
      (r) => emit(TaskCreated()),
    );
  }

  Future<void> _updateTask(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    final response = await taskUsecase.updateTask(event.task);
    response.fold(
      (l) => emit(TaskError(l.message!)),
      (r) => emit(TaskUpdated()),
    );
  }

  Future<void> _deleteTask(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    final response = await taskUsecase.deleteTask(event.id);
    response.fold(
      (l) => emit(TaskError(l.message!)),
      (r) => emit(TaskDeleted()),
    );
  }

  Future<void> _syncTasks(SyncTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    final response = await taskUsecase.syncTasks(event.serverUrl);
    response.fold(
      (l) => emit(TaskError(l.message!)),
      (r) => emit(TaskSynced()),
    );
  }
}
