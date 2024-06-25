import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_task_app/screens/signin_screen.dart';

void main() {
  testWidgets('description', (WidgetTester tester) async {
    await tester.pumpWidget(SigninScreen());

    final textFiledEmail = find.byKey(const Key('textFieldSigninEmail'));
    final textFiledSenha = find.byKey(const Key('textFieldSigninSenha'));
    final btnAcessar = find.text('Acessar');

    tester.enterText(textFiledEmail, "tiagoserra@email.com.br");
    tester.enterText(textFiledSenha, "mudar@123");
    tester.tap(btnAcessar);

    expect(textFiledEmail, findsOneWidget);
  });
}