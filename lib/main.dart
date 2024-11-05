import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testflutter/ToDoApp/home_page.dart';

void main() async
{
  //init the hive
  await Hive.initFlutter();

  //open the Box
  var box = await Hive.openBox('mybox');

  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.yellow
      ),
      home:  HomePage(),
    );
  }
}
