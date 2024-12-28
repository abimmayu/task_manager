import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';
import 'package:task_manager/features/task/presentation/bloc/task_bloc.dart';

class DropdownFilterTask extends StatelessWidget {
  const DropdownFilterTask({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<TaskStatus>(
      hint: const Text('Filter by status'),
      items: TaskStatus.values.map((status) {
        return DropdownMenuItem(
          value: status,
          child: Text(status.name),
        );
      }).toList(),
      onChanged: (status) {
        if (status != null) {
          context.read<TaskBloc>().add(
                FilterTasksEvent(status),
              );
        }
      },
    );
  }
}
