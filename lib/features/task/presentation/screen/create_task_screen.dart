import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/widget/button.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';
import 'package:task_manager/features/task/presentation/bloc/task/task_bloc.dart';
import 'package:task_manager/features/task/presentation/screen/widget/bottom_nav_bar.dart';
import 'package:task_manager/features/task/presentation/screen/widget/dropdown_due_date.dart';
import 'package:task_manager/features/task/presentation/screen/widget/text_form_create_task.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController dueDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormCreateTaskWidget(
              controller: titleController,
              hintText: 'Title',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title cannot be empty';
                }
                return null;
              },
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
            BlocConsumer<TaskBloc, TaskState>(listener: (context, state) {
              if (state is TaskError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              } else if (state is TaskCreated) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Success'),
                      content: const Text('Task has been created'),
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
                hintText: 'Submit',
                onTap: () {
                  DateTime selectedDate =
                      DateTime.parse(dueDateController.text);
                  if (titleController.text.isEmpty &&
                      dueDateController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Title, Due Date, and Status cannot be empty'),
                      ),
                    );
                    return;
                  } else if (titleController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Title cannot be empty'),
                      ),
                    );
                    return;
                  } else if (dueDateController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Due date cannot be empty'),
                      ),
                    );
                    return;
                  }
                  return context.read<TaskBloc>().add(
                        AddTaskEvent(
                          Tasks(
                            title: titleController.text,
                            description: descriptionController.text,
                            dueDate: selectedDate,
                            status: TaskStatus.pending,
                          ),
                        ),
                      );
                },
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
    );
  }
}
