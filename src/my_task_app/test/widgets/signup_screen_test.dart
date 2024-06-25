import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_task_app/providers/auth_provider.dart';
import 'package:my_task_app/routes.dart';
import 'package:my_task_app/screens/signup_screen.dart';
import 'package:provider/provider.dart';

Future<void> initializeFirebase() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

void main() {
  testWidgets('SignupScreen has a text field for email, password and a button', (WidgetTester tester) async {

    await initializeFirebase();

    await tester.pumpWidget(
      ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
        child: MaterialApp(
          home: SignupScreen(),
          routes: {
            Routes.HOME: (context) => const Scaffold(body: Center(child: Text('Home Screen'))),
            Routes.SIGNUPPICTURE: (context) => const Scaffold(body: Center(child: Text('Signup Picture Screen'))),
          },
        ),
      ),
    );

    final textFieldEmail = find.byKey(const Key('textFieldSigninEmail'));
    final textFieldSenha = find.byKey(const Key('textFieldSigninSenha'));
    final btnCadastrar = find.text('Cadastrar');

    await tester.pumpAndSettle();

    expect(textFieldEmail, findsOneWidget);
    expect(textFieldSenha, findsOneWidget);
    expect(btnCadastrar, findsOneWidget);

    await tester.enterText(textFieldEmail, "tiagoserra@email.com.br");
    await tester.enterText(textFieldSenha, "Cadastrar123");
    await tester.tap(btnCadastrar);

    await tester.pumpAndSettle();

    expect(find.text('Home Screen'), findsOneWidget);
  });
}