import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/utils/text_style.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';
import 'package:task_manager/features/task/presentation/bloc/task_bloc.dart';
import 'package:task_manager/features/task/presentation/screen/widget/dropdown_filter_task.dart';
import 'package:task_manager/features/task/presentation/screen/widget/search_bar.dart';
import 'package:task_manager/features/task/presentation/screen/widget/task_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    _selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(50.w),
          child: Column(
            children: [
              buildProfile(),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SearchTaskWidget(),
                    SizedBox(
                      width: 100.w,
                    ),
                    const DropdownFilterTask(),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              const Divider(),
              SizedBox(
                height: 50.h,
              ),
              BlocBuilder<TaskBloc, TaskState>(
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
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
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
        Flexible(
          child: Text(
            "Abim Mayu Indra Ardiansah",
            style: AppTextStyle.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget buildTaskCard(List<Tasks> tasks) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final data = tasks[index];
          final format = DateFormat('yyyy-MM-dd');
          final date = format.parse(data.dueDate.toString());
          return Column(
            children: [
              TaskCard(
                title: data.title,
                dueDate: "$date",
                status: data.status.name,
                onEdit: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Editing Task ${index + 1}')),
                  );
                },
                onDelete: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sharing Task ${index + 1}')),
                  );
                },
              ),
              SizedBox(
                height: 50.h,
              )
            ],
          );
        },
      ),
    );
  }
}
