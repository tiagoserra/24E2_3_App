import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_task_app/providers/auth_provider.dart';
import 'package:my_task_app/providers/task_provider.dart';
import 'package:my_task_app/screens/home_screen.dart';
import 'package:my_task_app/screens/signin_screen.dart';
import 'package:my_task_app/screens/signup_screen.dart';
import 'package:my_task_app/screens/task_details_screen.dart';
import 'package:my_task_app/screens/task_form_screen.dart';
import 'package:provider/provider.dart';

import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskProvider>(create: (context) => TaskProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Auto Control Panel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent)),
        routes: { 
          Routes.SIGNIN: (context) => SigninScreen(),
          Routes.SIGNUP: (context) => SignupScreen(),
          Routes.HOME: (context) => const HomeScreen(),
          Routes.TASK_FORM_SCREEN: (context) => const TaskFormScreen(),
          Routes.TASK_DETAILS_SCREEN: (context) =>  TaskDetailsScreen(),
        },
      ),
    );
  }
}