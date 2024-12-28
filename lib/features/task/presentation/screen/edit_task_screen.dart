import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/widget/button.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';
import 'package:task_manager/features/task/presentation/bloc/task/task_bloc.dart';
import 'package:task_manager/features/task/presentation/screen/widget/dropdown_due_date.dart';
import 'package:task_manager/features/task/presentation/screen/widget/dropdown_filter_task.dart';
import 'package:task_manager/features/task/presentation/screen/widget/text_form_create_task.dart';

class EditTaskParam {
  final Tasks task;

  EditTaskParam(this.task);
}

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.param});

  final EditTaskParam param;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController dueDateController = TextEditingController();

  TaskStatus? status;

  @override
  void initState() {
    titleController.text = widget.param.task.title;
    descriptionController.text = widget.param.task.description ?? '';
    dueDateController.text = widget.param.task.dueDate.toString();
    status = widget.param.task.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormCreateTaskWidget(
            controller: titleController,
            hintText: 'Title',
          ),
          SizedBox(height: 50.h),
          TextFormCreateTaskWidget(
            controller: descriptionController,
            hintText: 'Description',
          ),
          SizedBox(height: 50.h),
          DropdownDueDate(
            timeController: dueDateController,
          ),
          SizedBox(height: 50.h),
          DropdownFilterTask(
            onChanged: (selectedStatus) {
              setState(() {
                status = selectedStatus;
              });
            },
            status: status,
          ),
          SizedBox(height: 50.h),
          BlocConsumer<TaskBloc, TaskState>(listener: (context, state) {
            if (state is TaskUpdated) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Success'),
                    content: const Text('Task updated successfully'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          }, builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ButtonFilled(
              hintText: 'Updated',
              onTap: () {
                DateTime selectedDate = DateTime.parse(dueDateController.text);
                log("Due Date Change to: ${dueDateController.text}");
                if (titleController.text.isEmpty ||
                    dueDateController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Title, Due Date, and Status cannot be empty'),
                    ),
                  );
                  return;
                }
                if (titleController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Title cannot be empty'),
                    ),
                  );
                  return;
                }
                if (dueDateController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Due date cannot be empty'),
                    ),
                  );
                  return;
                }
                return context.read<TaskBloc>().add(
                      UpdateTaskEvent(
                        Tasks(
                          id: widget.param.task.id,
                          title: titleController.text,
                          description: descriptionController.text,
                          dueDate: selectedDate,
                          status: status!,
                        ),
                      ),
                    );
              },
            );
          }),
        ],
      ),
    );
  }
}
