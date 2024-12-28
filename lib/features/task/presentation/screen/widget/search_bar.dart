import 'package:flutter/material.dart';

class SearchTaskWidget extends StatelessWidget {
  const SearchTaskWidget(
      {super.key, required this.onChanged, required this.queryController});

  final Function(String) onChanged;
  final TextEditingController queryController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: queryController,
        decoration: const InputDecoration(
          hintText: 'Search tasks...',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
