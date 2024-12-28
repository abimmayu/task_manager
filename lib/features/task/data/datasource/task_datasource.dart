import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_manager/core/service/local_storage/database.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';
import 'package:timezone/timezone.dart' as tz;

abstract class TaskDatasource {
  Future<int> createTask(Tasks task);
  Future<List<Tasks>> fetchTasks();
  Future<List<Tasks>> searchAndFilterTasks({String? query, String? status});
  Future<int> updateTask(Tasks task);
  Future<int> deleteTask(int id);
  Future<List<Tasks>> fetchUnsyncedTasks();
  Future<void> syncTasks(String serverUrl, {Map<String, dynamic>? headers});
  Future<void> scheduleNotification(
      int id, String title, String body, DateTime dueDate);
}

class TaskDatasourceImpl implements TaskDatasource {
  final TaskDatabase db = TaskDatabase.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  Future<int> createTask(Tasks task) async => await db.insertTask(task);

  @override
  Future<List<Tasks>> fetchTasks() async => await db.fetchTasks();

  @override
  Future<List<Tasks>> searchAndFilterTasks(
          {String? query, String? status}) async =>
      await db.searchAndFilterTasks(query: query, status: status);

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

  @override
  Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    DateTime dueDate,
  ) async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetail = NotificationDetails(
      android: androidDetails,
    );

    return await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(dueDate, tz.local),
      notificationDetail,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}
