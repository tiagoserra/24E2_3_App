import 'package:flutter/material.dart';
import 'package:management_task_package/models/task_model.dart';
import 'package:my_task_app/routes.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile(
    this.task, {
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final date = task.dateTime != null
        ? '${task.dateTime.day}/${task.dateTime.month}/${task.dateTime.year}'
        : '';

    return ListTile(
      title: Text(task.name),
      subtitle: Text(date),
      leading: const Icon(Icons.task_sharp),
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.TASK_DETAILS_SCREEN,
          arguments: task,
        );
      },
    );
  }
}
