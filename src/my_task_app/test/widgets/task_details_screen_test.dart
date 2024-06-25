import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:management_task_package/models/task_model.dart';
import 'package:my_task_app/providers/task_provider.dart';
import 'package:my_task_app/routes.dart';
import 'package:my_task_app/screens/task_details_screen.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('TaskDetailsScreen displays task details and allows deletion', (WidgetTester tester) async {

    final mockTaskProvider = TaskProvider();
    final task = Task(id: '1', name: 'Test Task', dateTime: DateTime.now(), image:"image");

    await tester.pumpWidget(
      ChangeNotifierProvider<TaskProvider>.value(
        value: mockTaskProvider,
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailsScreen(),
                      settings: RouteSettings(arguments: task),
                    ),
                  );
                },
                child: const Text('Go to TaskDetailsScreen'),
              );
            },
          ),
          routes: {
            Routes.HOME: (context) => const Scaffold(body: Center(child: Text('Home Screen'))),
          },
        ),
      ),
    );

    await tester.tap(find.text('Go to TaskDetailsScreen'));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.descendant(of: find.byType(TextField).first, matching: find.text('Test Task')), findsOneWidget);
    expect(find.descendant(of: find.byType(TextField).last, matching: find.text(DateFormat('yyyy-MM-dd').format(task.dateTime))), findsOneWidget);

    final deleteButton = find.byIcon(Icons.delete_forever);
    expect(deleteButton, findsOneWidget);
    await tester.tap(deleteButton);

    await tester.pumpAndSettle();
    expect(find.text('Home Screen'), findsOneWidget);
  });
}