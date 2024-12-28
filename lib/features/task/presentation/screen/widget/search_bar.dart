import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task/presentation/bloc/task_bloc.dart';

class SearchTaskWidget extends StatefulWidget {
  const SearchTaskWidget({super.key});

  @override
  State<SearchTaskWidget> createState() => _SearchTaskWidgetState();
}

class _SearchTaskWidgetState extends State<SearchTaskWidget> {
  final TextEditingController queryController = TextEditingController();

  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: queryController,
        decoration: const InputDecoration(
          hintText: 'Search tasks...',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (query) {
          context.read<TaskBloc>().add(SearchTasksEvent(query));
        },
      ),
    );
  }
}
