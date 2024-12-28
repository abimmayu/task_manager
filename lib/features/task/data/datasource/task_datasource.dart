import 'package:task_manager/core/service/local_storage/database.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';

abstract class TaskDatasource {
  Future<int> createTask(Tasks task);
  Future<List<Tasks>> fetchTasks();
  Future<List<Tasks>> searchTasks(String query);
  Future<List<Tasks>> filterTasks(TaskStatus status);
  Future<int> updateTask(Tasks task);
  Future<int> deleteTask(int id);
  Future<List<Tasks>> fetchUnsyncedTasks();
  Future<void> syncTasks(String serverUrl, {Map<String, dynamic>? headers});
}

class TaskDatasourceImpl implements TaskDatasource {
  final TaskDatabase db = TaskDatabase.instance;
  @override
  Future<int> createTask(Tasks task) async => await db.insertTask(task);

  @override
  Future<List<Tasks>> fetchTasks() async => await db.fetchTasks();

  @override
  Future<List<Tasks>> searchTasks(String query) async =>
      await db.searchTasks(query);

  @override
  Future<List<Tasks>> filterTasks(TaskStatus status) async =>
      await db.filterTasks(status);

  @override
  Future<int> updateTask(Tasks task) async => await db.updateTask(task);

  @override
  Future<int> deleteTask(int id) async => await db.deleteTask(id);

  @override
  Future<List<Tasks>> fetchUnsyncedTasks() async =>
      await db.fetchUnsyncedTasks();

  @override
  Future<void> syncTasks(String serverUrl,
          {Map<String, dynamic>? headers}) async =>
      await db.syncTasks(serverUrl, headers: headers);
}
