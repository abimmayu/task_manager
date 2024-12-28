import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';

@immutable
class TaskDatabase {
  static const String _databaseName = 'tasks.db';
  static const int _databaseVersion = 1;

  const TaskDatabase._privateConstructor();
  static const TaskDatabase instance = TaskDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        dueDate TEXT NOT NULL,
        status TEXT NOT NULL,
        isSynced INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  Future<int> insertTask(Tasks task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Tasks>> fetchTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return maps.map((map) {
      log("data $map");
      return Tasks.fromMap(map);
    }).toList();
  }

  Future<List<Tasks>> searchAndFilterTasks(
      {String? query, String? status}) async {
    final db = await database;
    String whereClause = '';
    List<String> whereArgs = [];

    if (query != null && query.isNotEmpty) {
      whereClause += 'title LIKE ?';
      whereArgs.add('%$query%');
    }

    if (status != null) {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      whereClause += 'status = ?';
      whereArgs.add(status);
    }

    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: whereClause.isNotEmpty ? whereClause : null,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );

    return maps.map((map) {
      log("data $map");
      return Tasks.fromMap(map);
    }).toList();
  }

  Future<int> updateTask(Tasks task) async {
    final db = await database;
    log("Task Update: ${task.toMap()}");
    final response = await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    log("update data: $response");
    return response;
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Tasks>> fetchUnsyncedTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'isSynced = 0',
    );
    return maps.map((map) => Tasks.fromMap(map)).toList();
  }

  Future<void> syncTasks(
    String serverUrl, {
    Map<String, dynamic>? headers,
  }) async {
    final unsyncedTasks = await fetchUnsyncedTasks();

    for (final task in unsyncedTasks) {
      final response = await Dio().post(
        serverUrl,
        data: task.toMap(),
        options: Options(
          headers: headers,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        final db = await database;
        await db.update(
          'tasks',
          {'isSynced': 1},
          where: 'id = ?',
          whereArgs: [task.id],
        );
      }
    }
  }
}
