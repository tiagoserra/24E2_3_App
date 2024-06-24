import 'package:flutter/material.dart';
import 'package:my_task_app/providers/auth_provider.dart';
import 'package:my_task_app/routes.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.watch<AuthProvider>();
    String? message = authProvider.message;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextField(
              key: const Key('textFieldSigninEmail'),
              controller: emailController,
              decoration: const InputDecoration(
                label: Text("email"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextField(
              key: const Key('textFieldSigninSenha'),
              controller: passwordController,
              decoration: const InputDecoration(
                label: Text("senha"),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String email = emailController.text;
              String password = passwordController.text;
              authProvider.signIn(email, password).then(
                    (response) => {
                      if (response) Navigator.pushNamed(context, Routes.HOME)
                    },
                  );
            },
            child: const Text("Acessar"),
          ),
          if (message != null) Text(message),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.SIGNUP);
            },
            child: const Text("Ainda não tenho cadastro!"),
          ),
        ],
      ),
    );
  }
}