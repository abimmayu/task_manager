import 'package:task_manager/core/error/failure.dart';

class TaskReadError extends Failure {
  TaskReadError({super.message})
      : super(
          title: "Task Read Error!",
        );
}

class TaskWriteError extends Failure {
  TaskWriteError({super.message})
      : super(
          title: "Task Write Error!",
        );
}

class TaskDeleteError extends Failure {
  TaskDeleteError({super.message})
      : super(
          title: "Task Delete Error!",
        );
}

class TaskUpdateError extends Failure {
  TaskUpdateError({super.message})
      : super(
          title: "Task Update Error!",
        );
}

class TaskSyncError extends Failure {
  TaskSyncError({super.message})
      : super(
          title: "Task Sync Error!",
        );
}
