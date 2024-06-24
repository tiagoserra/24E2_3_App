import 'package:flutter/material.dart';
import 'package:my_task_app/components/task_form.dart';

class TaskFormScreen extends StatelessWidget {
  const TaskFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova terefa'),
      ),
      body: TaskForm(),
    );
  }
}