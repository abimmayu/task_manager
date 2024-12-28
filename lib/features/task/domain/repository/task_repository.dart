import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';

abstract class TaskRepository {
  Future<Either<Failure, int>> createTask(Tasks task);
  Future<Either<Failure, List<Tasks>>> fetchTasks();
  Future<Either<Failure, List<Tasks>>> searchTasks(String query);
  Future<Either<Failure, List<Tasks>>> filterTasks(TaskStatus status);
  Future<Either<Failure, int>> updateTask(Tasks task);
  Future<Either<Failure, int>> deleteTask(int id);
  Future<Either<Failure, List<Tasks>>> fetchUnsyncedTasks();
  Future<Either<Failure, void>> syncTasks(
    String serverUrl,
  );
}
