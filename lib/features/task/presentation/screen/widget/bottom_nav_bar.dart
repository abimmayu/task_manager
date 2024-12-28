import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/route/route.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: onItemTapped,
    );
  }

  void onItemTapped(int index) {
    switch (index) {
      case 0:
        context.goNamed(AppRoute.homeScreen.name);
        break;
      case 1:
        context.goNamed(AppRoute.createTaskScreen.name);
        break;
      case 2:
        context.goNamed(AppRoute.settingScreen.name);
        break;
    }
  }
}
