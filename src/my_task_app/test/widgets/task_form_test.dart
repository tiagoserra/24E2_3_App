import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:management_task_package/models/task_model.dart';
import 'package:my_task_app/providers/task_provider.dart';
import 'package:my_task_app/routes.dart';
import 'package:my_task_app/screens/task_details_screen.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('TaskDetailsScreen displays task details and allows deletion',
      (WidgetTester tester) async {
    final mockTaskProvider = TaskProvider();
    final task = Task(
        id: '1', name: 'Task teste 0123', dateTime: DateTime.now(), image: "image");

    await tester.pumpWidget(
      ChangeNotifierProvider<TaskProvider>.value(
        value: mockTaskProvider,
        child: MaterialApp(
          home: const Scaffold(body: Center(child: Text('Home Screen'))),
          routes: {
            '/taskDetails': (context) => TaskDetailsScreen(),
            Routes.HOME: (context) =>
                const Scaffold(body: Center(child: Text('Home Screen'))),
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    Navigator.push(
      tester.element(find.byType(Scaffold)),
      MaterialPageRoute(
        builder: (context) => TaskDetailsScreen(),
        settings: RouteSettings(arguments: task),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Task teste 0123').evaluate().length, 2);

    expect(
        find
            .text(DateFormat('yyyy-MM-dd').format(task.dateTime))
            .evaluate()
            .length,
        1);

    final deleteButton = find.byIcon(Icons.delete_forever);
    expect(deleteButton, findsOneWidget);
    await tester.tap(deleteButton);

    await tester.pumpAndSettle();
    expect(find.text('Home Screen'), findsOneWidget);
  });
}
