// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_app/provider/todo_provider.dart';
import 'package:flutter_todo_app/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ChangeNotifierProvider(create: (_) => ToDoProvider(),
     child: MaterialApp(     
      home: Home(),
    )
    );
  }
}
