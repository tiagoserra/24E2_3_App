import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:management_task_package/models/task_model.dart';
import 'package:my_task_app/providers/task_provider.dart';
import 'package:my_task_app/widgets/date_input_widget.dart';
import 'package:provider/provider.dart';

class TaskForm extends StatelessWidget {
  TaskForm({super.key});

  final name = TextEditingController();
  final datetime = TextEditingController();

  Future<LocationData?> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    try {
      serviceEnabled = await location.serviceEnabled();

      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return null;
        }
      }

      permissionGranted = await location.hasPermission();

      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }

      return await location.getLocation();
    } on Exception catch (e) {
      print("Error obtaining location: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final addTask = taskProvider.insert;

    return SizedBox(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: name,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),
          ),
          DateInputWidget(controller: datetime),
          ElevatedButton(
            onPressed: () async {

              //final location = await getLocation();

              final task = Task(
                  name: name.text,
                  dateTime: DateTime.parse(datetime.text),
                  image: "image");

              addTask(task);

              name.clear();
              datetime.clear();
            },
            child: const Text('Adicionar'),
          )
        ],
      ),
    );
  }
}
