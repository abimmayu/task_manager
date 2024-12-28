import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';

class DropdownFilterTask extends StatelessWidget {
  const DropdownFilterTask({
    super.key,
    required this.onChanged,
    required this.status,
  });

  final void Function(TaskStatus?)? onChanged;
  final TaskStatus? status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<TaskStatus>(
        alignment: Alignment.center,
        value: status,
        hint: const Text('Filter by status'),
        items: TaskStatus.values.map(
          (status) {
            return DropdownMenuItem(
              value: status,
              child: Text(status.name),
            );
          },
        ).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
