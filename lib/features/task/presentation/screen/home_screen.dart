import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/route/route.dart';
import 'package:task_manager/core/utils/text_style.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';
import 'package:task_manager/features/task/presentation/bloc/task/task_bloc.dart';
import 'package:task_manager/features/task/presentation/screen/edit_task_screen.dart';
import 'package:task_manager/features/task/presentation/screen/widget/bottom_nav_bar.dart';
import 'package:task_manager/features/task/presentation/screen/widget/dropdown_filter_task.dart';
import 'package:task_manager/features/task/presentation/screen/widget/search_bar.dart';
import 'package:task_manager/features/task/presentation/screen/widget/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskStatus? status;
  String? query;

  TextEditingController queryController = TextEditingController();

  @override
  void initState() {
    context.read<TaskBloc>().add(
          FetchTasksEvent(),
        );
    super.initState();
  }

  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              query = null;
              status = null;
              queryController.clear();
            });
            context.read<TaskBloc>().add(
                  FetchTasksEvent(),
                );
          },
          child: ListView(
            padding: EdgeInsets.all(50.w),
            children: [
              buildProfile(),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 50.h,
              ),
              const Divider(),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SearchTaskWidget(
                      queryController: queryController,
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                        context.read<TaskBloc>().add(
                              SearchAndFilterTasksEvent(
                                query: query,
                                status: status?.name,
                              ),
                            );
                      },
                    ),
                    SizedBox(
                      width: 100.w,
                    ),
                    Expanded(
                      child: DropdownFilterTask(
                        onChanged: (statusSelected) {
                          setState(() {
                            status = statusSelected;
                          });
                          context.read<TaskBloc>().add(
                                SearchAndFilterTasksEvent(
                                  query: query,
                                  status: status?.name,
                                ),
                              );
                          debugPrint('Filter by status: $status');
                        },
                        status: status,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              BlocConsumer<TaskBloc, TaskState>(
                listener: (context, state) {
                  log("state: $state");
                  if (state is TaskDeleted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Task Deleted"),
                      ),
                    );
                  } else if (state is TaskNotificationScheduled) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Notification Scheduled"),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TaskLoaded) {
                    if (state.tasksList.isEmpty) {
                      return const Text("Data empty");
                    } else {
                      return buildTaskCard(state.tasksList);
                    }
                  }
                  return const Text("Data empty");
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBar(
          selectedIndex: 0,
        ),
      ),
    );
  }

  Widget buildProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 200.w,
          width: 200.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.w),
            child: Image.network(
              "https://img.freepik.com/free-photo/portrait-man-working-laptop_23-2148898741.jpg",
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/profile_placeholder.png',
                  fit: BoxFit.cover,
                );
              },
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 200.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  "Abim Mayu Indra Ardiansah",
                  style: AppTextStyle.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Flexible(
                child: Text(
                  "Mobile Developer",
                  style: AppTextStyle.title.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTaskCard(List<Tasks> tasks) {
    return SizedBox(
      height: 1400.h,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final data = tasks[index];
                DateFormat format = DateFormat('dd-MM-yyyy HH:mm');
                String date = format.format(data.dueDate);
                return Column(
                  children: [
                    TaskCard(
                      title: data.title,
                      dueDate: date,
                      status: data.status.name,
                      onEdit: () {
                        context.goNamed(
                          AppRoute.editTaskScreen.name,
                          extra: EditTaskParam(data),
                        );
                      },
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Delete Task"),
                              content: const Text(
                                  "Are you sure want to delete this task?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.read<TaskBloc>().add(
                                          DeleteTaskEvent(data.id!),
                                        );
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onNotification: () => context.read<TaskBloc>().add(
                            ScheduleNotificationEvent(
                              data.id!,
                              "Your Task Has Come!",
                              data.title,
                              data.dueDate,
                            ),
                          ),
                    ),
                    SizedBox(
                      height: 50.h,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
