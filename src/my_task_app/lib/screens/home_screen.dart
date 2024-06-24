import 'package:flutter/material.dart';
import 'package:my_task_app/components/task_list.dart';
import 'package:my_task_app/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Minhas tarefas'),
        ),
        body: const TaskList(),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Adicionar tarefa'),
                leading: const Icon(Icons.add_task_rounded),
                onTap: () {
                  Navigator.pushNamed(context, Routes.TASK_FORM_SCREEN);
                },
              )
            ],
          ),
        ));
  }
}
