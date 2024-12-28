enum TaskStatus { pending, inProgress, completed }

class Tasks {
  int? id;
  String title;
  String? description;
  DateTime dueDate;
  TaskStatus status;

  Tasks({
    this.id,
    required this.title,
    this.description,
    required this.dueDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'status': status.index,
    };
  }

  factory Tasks.fromMap(Map<String, dynamic> map) {
    return Tasks(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      status: TaskStatus.values[map['status']],
    );
  }
}
