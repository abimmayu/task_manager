import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/core/error/task_error.dart';
import 'package:task_manager/features/task/data/datasource/task_datasource.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';
import 'package:task_manager/features/task/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDatasource taskDatasource;

  TaskRepositoryImpl(this.taskDatasource);

  @override
  Future<Either<Failure, int>> createTask(Tasks task) async {
    try {
      final response = await taskDatasource.createTask(task);
      return Right(response);
    } on Exception catch (e) {
      return Left(
        TaskWriteError(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<Tasks>>> fetchTasks() async {
    try {
      final response = await taskDatasource.fetchTasks();
      return Right(response);
    } on Exception catch (e) {
      return Left(
        TaskReadError(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<Tasks>>> searchTasks(String query) async {
    try {
      final response = await taskDatasource.searchTasks(query);
      return Right(response);
    } on Exception catch (e) {
      return Left(
        TaskReadError(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<Tasks>>> filterTasks(TaskStatus status) async {
    try {
      final response = await taskDatasource.filterTasks(status);
      return Right(response);
    } on Exception catch (e) {
      return Left(
        TaskReadError(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, int>> updateTask(Tasks task) async {
    try {
      final response = await taskDatasource.updateTask(task);
      return Right(response);
    } on Exception catch (e) {
      return Left(
        TaskUpdateError(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, int>> deleteTask(int id) async {
    try {
      final response = await taskDatasource.deleteTask(id);
      return Right(response);
    } on Exception catch (e) {
      return Left(
        TaskDeleteError(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<Tasks>>> fetchUnsyncedTasks() async {
    try {
      final response = await taskDatasource.fetchUnsyncedTasks();
      return Right(response);
    } on Exception catch (e) {
      return Left(
        TaskReadError(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, void>> syncTasks(String serverUrl) async {
    try {
      final response = await taskDatasource.syncTasks(serverUrl);
      return Right(response);
    } on Exception catch (e) {
      return Left(
        TaskSyncError(message: e.toString()),
      );
    }
  }
}
