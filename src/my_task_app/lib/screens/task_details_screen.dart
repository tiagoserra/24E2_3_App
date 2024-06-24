import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_task_package/models/task_model.dart';
import 'package:my_task_app/providers/task_provider.dart';
import 'package:my_task_app/routes.dart';
import 'package:provider/provider.dart';

class TaskDetailsScreen extends StatelessWidget {
  
  TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)!.settings.arguments as Task;
    final screenDetailsName = task.name;

    final taskProvider = context.watch<TaskProvider>();
    final removeTask = taskProvider.delete;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(screenDetailsName),
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.edit),
          //   tooltip: 'Editar tarefa',
          //   onPressed: () {
                
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'remover tarefa',
            onPressed: () {
              removeTask(task);
              Navigator.pushReplacementNamed(context, Routes.HOME);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: TextEditingController(text: task.name),
                decoration: const InputDecoration(
                  labelText: 'tarefa',
                ),
                readOnly: true,
              ),
              TextField(
                controller: TextEditingController(
                    text: DateFormat('yyyy-MM-dd').format(task.dateTime)),
                decoration: const InputDecoration(
                  labelText: 'Data',
                ),
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
