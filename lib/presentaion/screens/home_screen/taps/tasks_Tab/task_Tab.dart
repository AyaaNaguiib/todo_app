import 'package:flutter/material.dart';
import 'package:todo_app/presentaion/screens/home_screen/taps/tasks_Tab/task_item/todo_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: TodoItem(),
    );
  }
}
