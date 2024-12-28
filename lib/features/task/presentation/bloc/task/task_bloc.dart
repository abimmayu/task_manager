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
    on<SearchAndFilterTasksEvent>(_searchAndFilterTasks);
    on<AddTaskEvent>(_addTask);
    on<UpdateTaskEvent>(_updateTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<SyncTasksEvent>(_syncTasks);
    on<ScheduleNotificationEvent>(_scheduleNotification);
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

  Future<void> _searchAndFilterTasks(
      SearchAndFilterTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    final response = await taskUsecase.searchAndFilterTasks(
      query: event.query,
      status: event.status,
    );

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

  Future<void> _addTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    final response = await taskUsecase.createTask(event.task);
    response.fold(
      (l) => emit(TaskError(l.message!)),
      (r) {
        emit(TaskCreated());
        add(FetchTasksEvent());
      },
    );
  }

  Future<void> _updateTask(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    final response = await taskUsecase.updateTask(event.task);
    response.fold(
      (l) => emit(TaskError(l.message!)),
      (r) {
        emit(TaskUpdated());
        add(FetchTasksEvent());
      },
    );
  }

  Future<void> _deleteTask(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    final response = await taskUsecase.deleteTask(event.id);
    response.fold(
      (l) => emit(TaskError(l.message!)),
      (r) {
        emit(TaskDeleted());
        add(FetchTasksEvent());
      },
    );
  }

  Future<void> _syncTasks(SyncTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    final response = await taskUsecase.syncTasks(event.serverUrl);
    response.fold(
      (l) => emit(TaskError(l.message!)),
      (r) {
        emit(TaskSynced());
        add(FetchTasksEvent());
      },
    );
  }

  Future<void> _scheduleNotification(
    ScheduleNotificationEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());

    final response = await taskUsecase.scheduleNotification(
      event.id,
      event.title,
      event.body,
      event.dueDate,
    );

    response.fold(
      (l) => emit(TaskError(l.message!)),
      (r) {
        emit(TaskNotificationScheduled());
        add(FetchTasksEvent());
      },
    );
  }
}
