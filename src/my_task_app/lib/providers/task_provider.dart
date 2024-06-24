import 'package:flutter/material.dart';
import 'package:management_task_package/models/task_model.dart';
import 'package:management_task_package/services/task_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task>? myTasks = [];
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void insert(Task task) async {
    
    Task insertedTask = await TaskService.insert(task);

    myTasks?.add(insertedTask);

    notifyListeners();
  }

  void update(int index, Task task) async {

    Task updatedTask = await TaskService.insert(task);

    myTasks?[index] = updatedTask;

    notifyListeners();
  }

  void delete(Task task) async {
    
    await TaskService.delete(task);

    int index = myTasks!.indexWhere((element) => element.name == task.name);

    if (index != -1) {
      myTasks?.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> initialize() async {
    myTasks = await TaskService.getAll();

    _isLoading = false;

    notifyListeners();
  }
}