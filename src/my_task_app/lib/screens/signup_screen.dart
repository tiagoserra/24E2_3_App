import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_task_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../routes.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? imagePath;
  String? email;
  String? password;

  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.watch<AuthProvider>();
    String? message = authProvider.message;

    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Informe o email para cadastro.',
                      labelText: 'Email'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Informe um email válido!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  // controller: ,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.key),
                      hintText: 'Informe uma senha para cadastro.',
                      labelText: 'Senha'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Informe uma senha válido!';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authProvider.signUp(email!, password!).then((sucesso) {
                      Navigator.pushReplacementNamed(context, Routes.HOME);
                    });
                  }
                },
                child: const Text("Cadastrar"),
              ),
              if (message != null) Text(message),
            ],
          ),
        ),
      ),
    );
  }
}
