import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
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
              imagePath != null
                  ? Stack(
                      children: [
                        Image.file(
                          width: 200,
                          height: 200,
                          File(imagePath!),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              imagePath = null;
                            });
                          },
                          icon: const Icon(Icons.delete),
                        )
                      ],
                    )
                  : IconButton(
                      onPressed: () async {
                        Object? result = await Navigator.of(context)
                            .pushNamed(Routes.SIGNUPPICTURE);
                        if (result != null) {
                          setState(() {
                            imagePath = result as String;
                          });
                        }
                      },
                      icon: const Icon(Icons.camera_alt),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  key: const Key('textFieldSigninEmail'),
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
                  key: const Key('textFieldSigninSenha'),
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
                      if (sucesso) {
                        // try {
                        //   var storage = FirebaseStorage.instance;
                        //   var reference = storage.ref();
                        //   var fileReference = reference.child("$email.jpg");
                        //   var imageFile = File(imagePath!);
                        //   fileReference.putFile(imageFile);
                        // } on FirebaseException catch (e) {
                        //   print('Erro FirebaseStorage: ${e.message}');
                        // }
                        Navigator.pushReplacementNamed(context, Routes.HOME);
                      } else {
                        // Pegar a mensagem de erro
                      }
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
