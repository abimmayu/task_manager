import 'package:dartz/dartz.dart';
import 'package:task_manager/core/error/failure.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';
import 'package:task_manager/features/task/domain/repository/task_repository.dart';

class TaskUsecase {
  final TaskRepository taskRepository;

  TaskUsecase(this.taskRepository);

  Future<Either<Failure, int>> createTask(Tasks task) =>
      taskRepository.createTask(task);

  Future<Either<Failure, List<Tasks>>> fetchTasks() =>
      taskRepository.fetchTasks();

  Future<Either<Failure, List<Tasks>>> searchTasks(String query) =>
      taskRepository.searchTasks(query);

  Future<Either<Failure, List<Tasks>>> filterTasks(TaskStatus status) =>
      taskRepository.filterTasks(status);

  Future<Either<Failure, int>> updateTask(Tasks task) =>
      taskRepository.updateTask(task);

  Future<Either<Failure, int>> deleteTask(int id) =>
      taskRepository.deleteTask(id);

  Future<Either<Failure, List<Tasks>>> fetchUnsyncedTasks() =>
      taskRepository.fetchUnsyncedTasks();

  Future<Either<Failure, void>> syncTasks(String serverUrl) =>
      taskRepository.syncTasks(serverUrl);
}
